package com.danim.service;

import com.danim.entity.Photo;
import com.danim.entity.Post;
import org.springframework.web.multipart.MultipartFile;

import javax.sound.sampled.UnsupportedAudioFileException;
import java.io.IOException;
import java.util.List;

public interface PostService {
    // 포스트 등록
    Post createPost(Post savedPost, String address1, String address2, String address3, String address4, MultipartFile flagFile, MultipartFile voiceFile, Long timelineId, List<Photo> photoList) throws Exception;

    // 포스트 삭제
    void deletePostById(Long postId) throws Exception;


    // 지역명 검색어에 따른 post 조회
//    List<Post> findByLocation(String location) throws Exception;
}
