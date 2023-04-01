package com.danim.service;

import com.danim.conponent.AwsS3;
import com.danim.conponent.ClovaSpeechClient;
import com.danim.dto.AddPostReq;
import com.danim.dto.GetPostRes;
import com.danim.entity.*;
import com.danim.exception.BaseException;
import com.danim.exception.ErrorMessage;
import com.danim.repository.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;


@Service
@RequiredArgsConstructor
@Slf4j
public class PostServiceImpl implements PostService {
    private final AwsS3 awsS3;
    private final PostRepository postRepository;
    private final PhotoRepository photoRepository;
    private final FavoriteRepository favoriteRepository;
    private final TimeLineRepository timelineRepository;
    private final NationRepository nationRepository;


    // 포스트 생성 및 저장
    @Override
    public Post createPost() throws Exception {
        Post post = new Post();
        Post savedPost = postRepository.save(post);
        return savedPost;
    }

    // 포스트 속성 값 설정 후 재저장
    @Transactional
    @Override
    public Post insertPost(Post savedPost, List<Photo> photoList, MultipartFile flagFile, MultipartFile voiceFile, AddPostReq addPostReq) throws Exception {

        //파일 형식과 길이를 파악을 하여 post를 등록 시킬지 안시킬지 정하는 부분이다
        String fileName = voiceFile.getOriginalFilename();
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
        if (!ext.equals("wav")) {
            System.out.println("웨이브 파일 아님");
            throw new BaseException(ErrorMessage.NOT_PERMIT_VOICE_SAVE);
        }

        //backend 폴더 하위에 temp라는 폴더를 생성, 즉 해당 되는 폴더가 없으면 임의로 생성을 한다는 것을 의미를 함
        Files.createDirectories(Paths.get("temp"));
        Path target = (Path) Paths.get("temp", voiceFile.getOriginalFilename());//파일이름으로 파일을 저장을 하고자 하며 , 경로를 의미
        try (InputStream inputStream = voiceFile.getInputStream()) {
            Files.copy(inputStream, target, StandardCopyOption.REPLACE_EXISTING);//파일 저장
        } catch (Exception e) {
            System.out.println("파일 임시파일에 저장 안 됨");
            throw new BaseException(ErrorMessage.NOT_PERMIT_VOICE_SAVE);
        }

        // 파일 길이 추출
        File file = new File(target.toUri());
        AudioFileFormat audioInputStream = AudioSystem.getAudioFileFormat(file);
        AudioFormat format = audioInputStream.getFormat();
        long frameLength = audioInputStream.getFrameLength();
        double durationInSeconds = (frameLength / format.getFrameRate());
        Files.delete(target);//파일을 삭제하는 코드임
        int check_time = (int) durationInSeconds;
        //System.out.println("Duration: " + durationInSeconds + " seconds");
        if (check_time > 30) {
            throw new BaseException(ErrorMessage.OVER_VOICE_TIME);
        }

        // voiceFile S3에 올리고 voiceURL 가져오기
        String voiceUrl = awsS3.upload(voiceFile, "Danim/Voice");

        // voiceFile -> text 변환 : clova speech api 요청 보내기
        final ClovaSpeechClient clovaSpeechClient = new ClovaSpeechClient();
        ClovaSpeechClient.NestRequestEntity requestEntity = new ClovaSpeechClient.NestRequestEntity();
        final String result = clovaSpeechClient.url(voiceUrl, requestEntity);

        // voiceFile -> text 변환 : 응답 결과 확인
        System.out.println(result);
        if (result.contains("\"result\":\"FAILED\"")) {
            new BaseException(ErrorMessage.NOT_STT_SAVE);
        }

        // voiceFile -> text 변환 : 응답받은 json 파일에서 text 추출
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode rootNode = objectMapper.readTree(result);
        String text = rootNode.get("text").asText();

        // timeline 객체 가져오기
        TimeLine timeline = timelineRepository.findById(addPostReq.getTimelineId()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_TIMELINE));

        // db에 저장된 국가인 경우 가져와서 사용, 새로운 국가인 경우 nation 저장 후 사용
        String address1 = addPostReq.getAddress1();
        Nation nation = nationRepository.findFirstByName(address1);
        if (nation == null) {
            nation = new Nation();
            String flagUrl = awsS3.upload(flagFile, "Danim/Nation");
            nation.setNationUrl(flagUrl);
            nation.setName(address1);
            nationRepository.save(nation);
        }


        // imageURL, voiceURL db에 저장하기
        log.info("Starting savePost transaction");
        savedPost.setPhotoList(photoList);
        savedPost.setVoiceUrl(voiceUrl);
        savedPost.setVoiceLength(durationInSeconds);
        savedPost.setNationUrl(nation.getNationUrl());
        savedPost.setAddress1(addPostReq.getAddress1());
        savedPost.setAddress2(addPostReq.getAddress2());
        savedPost.setAddress3(addPostReq.getAddress3());
        savedPost.setAddress4(addPostReq.getAddress4());
        savedPost.setText(text);
        savedPost.setTimelineId(timeline);
        savedPost.setNationId(nation);
        Post resavedPost = postRepository.save(savedPost);
        log.info("savePost Transaction complete");
        return resavedPost;
    }




    @Override
    public Post insertPostTest(Post savedPost, List<Photo> photoList,AddPostReq addPostReq) throws Exception {




        // timeline 객체 가져오기
        TimeLine timeline = timelineRepository.findById(addPostReq.getTimelineId()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_TIMELINE));

        // db에 저장된 국가인 경우 가져와서 사용, 새로운 국가인 경우 nation 저장 후 사용
        String address1 = addPostReq.getAddress1();
        Nation nation = nationRepository.findFirstByName(address1);
        if (nation == null) {
            nation = new Nation();
            nation.setNationUrl("testurl입니다");
            nation.setName(address1);
            nationRepository.save(nation);
        }


        // imageURL, voiceURL db에 저장하기
        log.info("Starting savePost transaction");
        savedPost.setPhotoList(photoList);
        savedPost.setVoiceUrl("테스트url");
        savedPost.setVoiceLength(77.44);
        savedPost.setNationUrl(nation.getNationUrl());
        savedPost.setAddress1(addPostReq.getAddress1());
        savedPost.setAddress2(addPostReq.getAddress2());
        savedPost.setAddress3(addPostReq.getAddress3());
        savedPost.setAddress4(addPostReq.getAddress4());
        savedPost.setText("테스트 Text");
        savedPost.setTimelineId(timeline);
        savedPost.setNationId(nation);
        Post resavedPost = postRepository.save(savedPost);
        log.info("savePost Transaction complete");
        return resavedPost;
    }
    
    

    // 포스트 삭제 및 해당 포스트의 삭제 사진
    @Override
    @Transactional
    public void deletePostById(Long postId) throws Exception {
        Post post = postRepository.findById(postId).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_POST));
        for (Photo p : post.getPhotoList()) awsS3.delete(p.getPhotoUrl());
        photoRepository.deleteAllByPostId(post);
        postRepository.deleteById(postId);
    }

    // 지역명 키워드로 포스트 조회
    @Override
    public List<GetPostRes> findByLocation(String location) throws Exception {
        List<Post> postList = postRepository.findByAddress1ContainsOrAddress2ContainsOrAddress3ContainsOrAddress4Contains(location, location, location, location).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_KEYWORD));
        List<GetPostRes> getPostResList = new ArrayList<>();
        for (Post post : postList) {
            Long totalFavorite = favoriteRepository.countByPostId(post);
            getPostResList.add(GetPostRes.builder(post, totalFavorite).build());
        }
        return getPostResList;
    }
}
