package com.danim.controller;

import com.danim.entity.Post;
import com.danim.service.PostService;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/api/auth/post")
@RestController
public class PostController {
    private final PostService postService;
//    public PostController(PostService postService) {
//        this.postService = postService;
//    }

    //포스트 등록
    @PostMapping("")
    public ResponseEntity<?> insertPost(@RequestParam("image") MultipartFile imageFile,
                                        @RequestParam("voice") MultipartFile voiceFile,
                                        @RequestParam("timelineId") Long timelineId) throws Exception {
        try {
            Post post = postService.insertPost(imageFile, voiceFile, timelineId);
            return ResponseEntity.ok(post);
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
