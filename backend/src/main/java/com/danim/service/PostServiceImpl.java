package com.danim.service;

import com.danim.conponent.AwsS3;
//import com.danim.conponent.ClovaSpeechClient;
import com.danim.entity.Nation;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.entity.TimeLine;
import com.danim.repository.NationRepository;
import com.danim.repository.PostRepository;
import com.danim.repository.TimeLineRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Service
@RequiredArgsConstructor
@Slf4j
public class PostServiceImpl implements PostService {
    private final AwsS3 awsS3;
    private final PostRepository postRepository;
    private final TimeLineRepository timelineRepository;
    private final NationRepository nationRepository;

    @Value("${test1.voiceurl}")
    private String voiceUrl;

    @Value("${test1.flagurl}")
    private String flagUrl;

    // 포스트 등록
    @Override
    public Post createPost(Post savedPost, List<Photo> photoList, String address1, String address2, String address3, String address4, MultipartFile flagFile, MultipartFile voiceFile, Long timelineId) throws Exception {

        // voiceFile S3에 올리고 voiceURL 가져오기
        String voiceUrl = awsS3.upload(voiceFile, "Danim/Voice");

        // voiceFile에서 voiceLength 가져오기
        // Parameter 1 of constructor in com.danim.service.PostServiceImpl required a bean of type 'com.danim.utils.VoiceUtils' that could not be found
//        Double voiceLength = VoiceUtils.getVoiceFileLength(voiceUrl);

        // voiceFile -> text 변환
//        final ClovaSpeechClient clovaSpeechClient = new ClovaSpeechClient();
//        NestRequestEntity requestEntity = new NestRequestEntity();
//        final String result =
//                clovaSpeechClient.upload(new File("/data/sample.mp4"), requestEntity);
//        //final String result = clovaSpeechClient.url("file URL", requestEntity);
//        //final String result = clovaSpeechClient.objectStorage("Object Storage key", requestEntity);
//        System.out.println(result);

        // timeline 객체 가져오기
        TimeLine timeline = timelineRepository.findById(timelineId).orElseThrow(() -> new Exception("존재하지 않는 타임라인"));

        // nation entity 생성 및 속성 값 입력 후 저장
        Nation nation = new Nation();
        String flagUrl = awsS3.upload(flagFile, "Danim/Nation");
        nation.setNationUrl(flagUrl);
        nation.setName(address1);
        Nation savedNation = nationRepository.save(nation);

        // imageURL, voiceURL db에 저장하기
        log.info("Starting savePost transaction");
        savedPost.setPhotoList(photoList);
        savedPost.setVoiceUrl(voiceUrl);
        savedPost.setVoiceLength(2.2);
        savedPost.setNationUrl(flagUrl);
        savedPost.setAddress1(address1);
        savedPost.setAddress2(address2);
        savedPost.setAddress3(address3);
        savedPost.setAddress4(address4);
//        savedPost.setText(text);
        savedPost.setTimelineId(timeline);
        savedPost.setNationId(savedNation);
        Post resavedPost = postRepository.save(savedPost);
        log.info("Transaction complete");
        return resavedPost;
    }

    // 포스트 삭제
    @Override
    public void deletePostById(Long postId) throws Exception {
        postRepository.deleteById(postId);
    }

    // 지역명 키워드로 포스트 조회
    @Override
    public List<Post> findByLocation(String location) throws Exception {
        List<Post> postList = postRepository.findByAddress1OrAddress2OrAddress3OrAddress4(location, location, location, location);
        return postList;
    }
}
