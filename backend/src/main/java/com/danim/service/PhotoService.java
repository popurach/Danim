package com.danim.service;

import com.danim.entity.Photo;
import com.danim.entity.Post;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface PhotoService {
    Photo createPhoto(MultipartFile imageFile) throws Exception;
    void insertPhoto(List<Photo> photoList, Post savedPost) throws Exception;
    List<Photo> findByPostId(Long postId) throws Exception;
}
