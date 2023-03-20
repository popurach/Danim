package com.danim.service;

import com.amazonaws.services.s3.AmazonS3Client;
import com.danim.conponent.AwsS3;
import com.danim.dto.InsertPostReq;
import com.danim.dto.InsertPostRes;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.repository.MultiPartRepository;
import com.danim.repository.PhotoRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

@Service
@AllArgsConstructor
public class MultiPartServiceImpl implements MultiPartService {
    private final AwsS3 awsS3;
    private final MultiPartRepository multiPartRepository;
    private final PhotoRepository photoRepository;
    @Override
    public InsertPostRes insertPost(InsertPostReq insertPostReq) throws Exception {
//        System.out.println(insertPostReq.getVoice());
//        System.out.println(insertPostReq.getVoice().getName());
//        System.out.println(insertPostReq.getVoice().getContentType());
//        System.out.println(insertPostReq.getVoice().getOriginalFilename());
        /*
        --------------- 위에서 사진 업로드 빼다 다 처리되어야함 ------------
        timelineID 최근에 만들어진거 받아와야함.
         */
        List<Photo> pts = new LinkedList<>();
        List<String> uploadedUrl = new ArrayList<>();
        for (MultipartFile multi: insertPostReq.getPhotos()) {
            uploadedUrl.add(awsS3.upload(insertPostReq.getPhotos().get(0),"Danim/Post"));
        }
        for (int i = 0; i<insertPostReq.getPhotos().size();i++){
            pts.add(Photo.builder().photoUrl(uploadedUrl.get(i)).lat(12.1).lng(13.1).build());
        }
        System.out.println("aws url :"+pts);
        Post p = multiPartRepository.save(Post.builder().address("서울").text("아브다").photoList(pts).build());
        for (int i = 0; i < pts.size(); i++) {
            pts.get(i).setPostId(p);
        }
        photoRepository.saveAll(pts);
        System.out.println(" Post register done");
        return null;
    }
}
