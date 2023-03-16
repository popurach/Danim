package com.danim.service;

import com.danim.entity.Photo;
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
    private final PhotoRepository photoRepository;

    @Override
    List<Photo> findByPostId(Long postId) throws Exception{
        List<Photo> postPhotos = photoRepository.findByPostId(postId);
        int size = postPhotos.size();
        List<Photo>


    }

    @Override
    Photo insertPhoto(MultipartFile imageFile) throws Exception{

    }

}
