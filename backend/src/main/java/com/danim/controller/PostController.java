package com.danim.controller;

import com.danim.dto.InsertPostReq;
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
                                    @ModelAttribute InsertPostReq insertPostReq) throws Exception {
        // 입력 값 잘 들어오는지 확인
        if (flagFile == null || imageFiles == null || voiceFile == null || insertPostReq == null) {
            throw new BaseException(ErrorMessage.VALIDATION_FAIL_EXCEPTION);
        }
        insertPostReq.validate();

        log.info("addPost transaction starts");
        Post savedPost = postService.createPost();
        List<Photo> photoList = photoService.createPhotoList(insertPostReq, imageFiles, savedPost);
        Post resavedPost = postService.insertPost(savedPost, photoList, flagFile, voiceFile, insertPostReq);
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
        List<Post> postList = postService.findByLocation(location);
        return ResponseEntity.ok(postList);
    }
}
