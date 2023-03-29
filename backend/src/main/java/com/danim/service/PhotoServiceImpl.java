package com.danim.service;

import com.danim.conponent.AwsS3;
import com.danim.dto.AddPostReq;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.repository.PhotoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;


@Log4j2
@Service
@RequiredArgsConstructor
public class PhotoServiceImpl implements PhotoService {
    private final AwsS3 awsS3;
    private final PhotoRepository photoRepository;

    // 각각의 imageFile을 Photo 객체로 저장 후 photo 객체들의 리스트를 반환 (이후, Post 속성 값 중 하나인 photoList에서 사용)
    @Override
    public List<Photo> createPhotoList(AddPostReq addPostReq, List<MultipartFile> imageFiles, Post savedPost) throws Exception {
        log.info("Starting createPhotoList transaction");
        List<Photo> photoList = new ArrayList<>();

        for (MultipartFile imageFile : imageFiles) {
            Photo savedPhoto = this.savePhoto(addPostReq, imageFile, savedPost);
            photoList.add(savedPhoto);
        }
        log.info("createPhotoList Transaction complete");
        return photoList;
    }


    private Photo savePhoto(AddPostReq addPostReq, MultipartFile imageFile, Post savedPost) throws Exception {
        // imageFile S3에 올리고 imageURL 가져오기
        String photoUrl = awsS3.upload(imageFile, "Danim/Post");

        // photo 객체 생성
        log.info("Starting savePhoto transaction");
        Photo photo = Photo.builder()
                .postId(savedPost)
                .photoUrl(photoUrl)
                .build();
        photoRepository.save(photo);
        log.info("savePhoto Transaction complete");
        return photo;
    }

    
}
