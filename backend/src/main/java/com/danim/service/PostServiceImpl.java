package com.danim.service;

import com.amazonaws.services.s3.AmazonS3;
import com.danim.entity.Nation;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.entity.TimeLine;
import com.danim.repository.PhotoRepository;
import com.danim.repository.PostRepository;
import com.danim.utils.imageUtils;
import com.danim.utils.voiceUtils;
import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.sound.sampled.UnsupportedAudioFileException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;


@Service
@RequiredArgsConstructor
@Slf4j
public class PostServiceImpl implements PostService {
    private final AmazonS3 s3Client;
    private final PhotoRepository photoRepository;
    private final PostRepository postRepository;

    // 포스트 등록
    @Override
    public Post insertPost(MultipartFile imageFile, MultipartFile voiceFile, Long timelineId) throws IOException, UnsupportedAudioFileException {
        // imageFile S3에 올리고 imageURL 가져오기
        String imageKey = UUID.randomUUID().toString();
        String photoUrl = uploadFileToS3(imageFile, imageKey);

        // voiceFile S3에 올리고 voiceURL 가져오기
        String voiceKey = UUID.randomUUID().toString();
        String voiceUrl = uploadFileToS3(voiceFile, voiceKey);

        // image metadata에서 lat,lng 지역 정보 가져오기
        HashMap<String, Double> location = imageUtils.extractLocationFromImage(imageFile);
        double lat = location.get("latitude");
        double lng = location.get("longitude");

        // voice에서 voiceLength 가져오기
        Long voiceLength = voiceUtils.extractVoiceLength(voiceFile);

        // voiceFile -> text 변환
        String text = "테스트용";

        // imageURL, voiceURL db에 저장하기
        log.info("Starting savePost transaction");
        TimeLine timeline = timeLineRepository.findById(timelineId).orElseThrow(() -> new Exception("존재하지 않는 타임라인"));
        Post post = Post.builder()
                .voiceUrl(voiceUrl)
                .voiceLength(voiceLength)
//                .nationUrl(String)
//                .address(String)
                .text(text)
                .timelineId(timeline)
//                .nationId(Nation)
//                .photoList(List<Photo>)
                .build();
        Post savedPost = postRepository.save(post);
        log.info("Transaction complete");

        log.info("Starting savePhoto transaction");
        Photo photo = Photo.builder()
                .photoUrl(photoUrl)
                .lat(lat)
                .lng(lng)
                .postId(savedPost)
                .build();
        photoRepository.save(photo);
        log.info("Transaction complete");

        return savedPost;
    };

    // (포스트 등록 번외편) 파일 s3 서버에 올리는 메서드
    private String uploadFileToS3(MultipartFile file, String key) throws IOException {
        String bucketName = "my-bucket-name"; // 버킷 생성 후 수정 필요
        s3Client.putObject(bucketName, key, file.getInputStream(), null);
        return s3Client.getUrl(bucketName, key).toString();
    }

    // 포스트 삭제
    @Override
    public void deletePostById(Long postId) throws Exception {
        postRepository.deleteById(postId);
    }

    // 지역명 키워드로 포스트 조회
    @Override
    public List<Post> findByLocation(String location) throws Exception {
        List<Post> posts = postRepository.findByLocation(location);
        return posts;
    }

}
