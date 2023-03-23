package com.danim.controller;

import com.danim.dto.ChangeFavoriteStatusRes;
import com.danim.entity.Post;
import com.danim.service.FavoriteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/api/auth/like")
@RestController
@Slf4j
public class FavoriteController {
    private final FavoriteService favoriteService;

    // 해당 유저가 포스트에 좋아요를 누른 경우 -> favorite 저장 (true 반환)
    // 해당 유저가 포스트에 좋아요를 취소한 경우 -> favorite 삭제 (false 반환)
    @PostMapping(value = "")
    public ResponseEntity<?> changeFavoriteStatus(@RequestParam Long postId, @RequestParam Long userUid) throws Exception {
        ChangeFavoriteStatusRes res = new ChangeFavoriteStatusRes();
        res.setFavorite(favoriteService.isFavorite(postId, userUid));
        res.setTotalFavorite(favoriteService.countFavorite(postId));
        return ResponseEntity.ok(res);
    }

    // 해당 유저가 좋아요 누른 포스트 검색
    @GetMapping(value = "")
    public ResponseEntity<?> getFavoritePostList(@RequestParam Long userUid) throws Exception {
        List<Post> favoritePostList = favoriteService.findFavoritePost(userUid);
        return ResponseEntity.ok(favoritePostList);
    }
}
