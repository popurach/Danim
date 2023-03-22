package com.danim.service;

import com.danim.entity.Photo;
import com.danim.entity.Post;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface FavoriteService {
    List<Photo> asdf(Double lat, Double lng, List<MultipartFile> imageFiles, Post savedPost) throws Exception;
}