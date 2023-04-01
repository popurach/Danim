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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        // 입력 테스트중
        System.out.println("flagFile:"+flagFile);

        Post savedPost = postService.createPost();
        List<Photo> photoList = photoService.createPhotoList(imageFiles, savedPost);
        postService.insertPost(savedPost, photoList, flagFile, voiceFile, addPostReq);

        // addPost 요청에 대한 응답으로 timelineId 반환
        Map<String, Object> res = new HashMap<>();
        res.put("timelineId",addPostReq.getTimelineId());
        return ResponseEntity.ok(res);
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
