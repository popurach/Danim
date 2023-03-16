package com.danim.service;

import com.danim.entity.Photo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface PhotoService {
    List<Photo> findByPostId(Long postId) throws Exception;
    Photo insertPhoto(MultipartFile imageFile) throws Exception;
}
