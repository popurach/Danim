package com.danim.controller;

import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.service.PhotoService;
import com.danim.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/api/auth/post")
@RestController
public class PostController {
    private final PostService postService;
    private final PhotoService photoService;

    //포스트 등록
    @PostMapping("")
    public ResponseEntity<?> insertPost(@RequestParam("images") List<MultipartFile> imageFiles,
                                        @RequestParam("voice") MultipartFile voiceFile,
                                        @RequestParam("timelineId") Long timelineId) throws Exception {
        try {
            List<Photo> photoList = new ArrayList<>();
            for (MultipartFile imageFile : imageFiles) {
                Photo photo = photoService.createPhoto(imageFile);
                photoList.add(photo);
            }
            Post savedPost = postService.insertPost(voiceFile, timelineId, photoList);
            photoService.insertPhoto(photoList, savedPost);
            return ResponseEntity.ok(savedPost);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    //포스트 삭제
    @DeleteMapping("/{postId}")
    public ResponseEntity<?> deletePost(@PathVariable Long postId) throws Exception {
        try {
            postService.deletePostById(postId);
            return ResponseEntity.ok().build();
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    //지역명 키워드로 포스트 조회
    @GetMapping("/{location}")
    public ResponseEntity<?> getPost(@PathVariable String location) throws Exception {
        try {
            List<Post> postList = postService.findByLocation(location);
            return ResponseEntity.ok(postList);
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
