package com.danim.controller;

import com.danim.dto.AddPostReq;
import com.danim.dto.GetPostRes;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.exception.BaseException;
import com.danim.exception.ErrorMessage;
import com.danim.service.PhotoService;
import com.danim.service.PostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/api/auth/post")
@RestController
@Slf4j
public class PostController {
    private final PostService postService;
    private final PhotoService photoService;

    //포스트 등록 (Address 1 - 국가 -> Address 4 - 동네)
    @PostMapping(value = "", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> addPost(@RequestPart MultipartFile flagFile,
                                    @RequestPart List<MultipartFile> imageFiles,
                                    @RequestPart MultipartFile voiceFile,
                                     @Valid @ModelAttribute AddPostReq addPostReq) throws Exception {

        log.info("addPost transaction starts");
        Post savedPost = postService.createPost();
        List<Photo> photoList = photoService.createPhotoList(imageFiles, savedPost);
        Post resavedPost = postService.insertPost(savedPost, photoList, flagFile, voiceFile, addPostReq);
        log.info("addPost transaction ends");
        return ResponseEntity.ok(resavedPost);
    }

    //포스트 삭제
    @DeleteMapping("/{postId}")
    public ResponseEntity<?> deletePost(@PathVariable Long postId) throws Exception {
        if (postId == null) {
            log.info("postId 값 없음");
            throw new BaseException(ErrorMessage.VALIDATION_FAIL_EXCEPTION);
        }
        postService.deletePostById(postId);
        return ResponseEntity.ok().build();
    }

    //지역명 키워드로 포스트 조회
    @GetMapping("/{location}")
    public ResponseEntity<?> getPost(@PathVariable String location) throws Exception {
        if (location == null) {
            log.info("location 값 없음");
            throw new BaseException(ErrorMessage.VALIDATION_FAIL_EXCEPTION);
        }
        List<GetPostRes> getPostResList = postService.findByLocation(location);
        return ResponseEntity.ok(getPostResList);
    }
}