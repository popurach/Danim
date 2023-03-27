package com.danim.service;

import com.danim.conponent.AwsS3;
import com.danim.conponent.ClovaSpeechClient;
import com.danim.dto.InsertPostReq;
import com.danim.entity.Nation;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.entity.TimeLine;
import com.danim.exception.BaseException;
import com.danim.exception.ErrorMessage;
import com.danim.repository.NationRepository;
import com.danim.repository.PhotoRepository;
import com.danim.repository.PostRepository;
import com.danim.repository.TimeLineRepository;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


import java.io.File;
import java.util.List;


@Service
@RequiredArgsConstructor
@Slf4j
public class PostServiceImpl implements PostService {
    private final AwsS3 awsS3;
    private final PostRepository postRepository;
    private final PhotoRepository photoRepository;
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
    @Override
    public Post insertPost(Post savedPost, List<Photo> photoList, MultipartFile flagFile, MultipartFile voiceFile, InsertPostReq insertPostReq) throws Exception {

        // voiceFile S3에 올리고 voiceURL 가져오기
        String voiceUrl = awsS3.upload(voiceFile, "Danim/Voice");

        // voiceFile에서 voiceLength 가져오기
//        Double voiceLength = VoiceUtils.getVoiceFileLength(voiceFile);

        // voiceFile -> text 변환
        final ClovaSpeechClient clovaSpeechClient = new ClovaSpeechClient();
        ClovaSpeechClient.NestRequestEntity requestEntity = new ClovaSpeechClient.NestRequestEntity();
        final String result = clovaSpeechClient.url(voiceUrl, requestEntity);

        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode rootNode = objectMapper.readTree(result);
        String text = rootNode.get("text").asText();

        // timeline 객체 가져오기
        TimeLine timeline = timelineRepository.findById(insertPostReq.getTimelineId()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_TIMELINE));

        // db에 저장된 국가인 경우 가져와서 사용, 새로운 국가인 경우 nation 저장 후 사용
        String address1 = insertPostReq.getAddress1();
        Nation nation = nationRepository.findByName(address1);
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
        savedPost.setVoiceLength(2.2);
        savedPost.setNationUrl(nation.getNationUrl());
        savedPost.setAddress1(insertPostReq.getAddress1());
        savedPost.setAddress2(insertPostReq.getAddress2());
        savedPost.setAddress3(insertPostReq.getAddress3());
        savedPost.setAddress4(insertPostReq.getAddress4());
        savedPost.setText(text);
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
        photoRepository.deleteAllByPostId(post);
        postRepository.deleteById(postId);
    }

    // 지역명 키워드로 포스트 조회
    @Override
    public List<Post> findByLocation(String location) throws Exception {
        List<Post> postList = postRepository.findByAddress1OrAddress2OrAddress3OrAddress4(location, location, location, location).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_KEYWORD));
        return postList;
    }
}
