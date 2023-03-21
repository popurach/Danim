package com.danim.service;

//import com.amazonaws.services.s3.AmazonS3;

import com.danim.conponent.AwsS3;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.entity.TimeLine;
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
    //    private final VoiceUtils voiceUtils;
    private final PostRepository postRepository;
    private final TimeLineRepository timelineRepository;

    @Value("${test1.voiceurl}")
    private String voiceUrl;

    @Value("${test1.flagurl}")
    private String flagUrl;

    // 포스트 등록
    @Override
    public Post createPost(Post savedPost, String address1, String address2, String address3, String address4, MultipartFile flagFile, MultipartFile voiceFile, Long timelineId, List<Photo> photoList) throws Exception {
        // voiceFile S3에 올리고 voiceURL 가져오기
//테스트용        String voiceUrl = awsS3.upload(voiceFile, "Voice");

        // voiceFile에서 voiceLength 가져오기
//        Long voiceLength = voiceUtils.extractVoiceLength(voiceFile);

        // voiceFile -> text 변환
//        String text = "테스트용";

        // timeline 객체 가져오기
        TimeLine timeline = timelineRepository.findById(timelineId).orElseThrow(() -> new Exception("존재하지 않는 타임라인"));

        // flagFile S3에 올리고 voiceURL 가져오기
////테스트용         String flagUrl = awsS3.upload(flagFile, "Nation");

        // imageURL, voiceURL db에 저장하기
        log.info("Starting savePost transaction");
//        savedPost.setPhotoList(photoList);
        savedPost.setVoiceUrl(voiceUrl);
//        savedPost.setVoiceLength(voiceLength);
        savedPost.setNationUrl(flagUrl);
        savedPost.setAddress1(address1);
//        savedPost.setText(text);
        savedPost.setTimelineId(timeline);
//        savedPost.setNationId(nation);
        Post resavedPost = postRepository.save(savedPost);
        log.info("Transaction complete");
        return resavedPost;

        // 파일 s3 서버에 올리는 메서드
//    private String uploadFileToS3(MultipartFile file, String key) throws IOException {
//        String bucketName = "my-bucket-name"; // 버킷 생성 후 수정 필요
//        s3Client.putObject(bucketName, key, file.getInputStream(), null);
//        return s3Client.getUrl(bucketName, key).toString();
//    }

    }

    // 포스트 삭제
    @Override
    public void deletePostById(Long postId) throws Exception {
        postRepository.deleteById(postId);
    }

    // 지역명 키워드로 포스트 조회
//    @Override
//    public List<Post> findByLocation(String location) throws Exception {
//        List<Post> postList = postRepository.finidByAddress(location);
//        return postList;
//    }


}
