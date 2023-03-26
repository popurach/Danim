package com.danim.controller;
import com.danim.dto.TokenRes;
import com.danim.dto.UserLoginReq;
import com.danim.dto.UserInfoRes;
import com.danim.entity.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.danim.service.UserService;
import org.springframework.http.HttpStatus;

import org.springframework.web.bind.annotation.*;
//import org.json.JSONObject;
import java.util.List;


@RequestMapping("/api")
@RestController
@Slf4j
public class UserController {
    private final UserService userService;

    @Autowired
    public UserController(UserService userService){
        this.userService = userService;
    }

    // 유저 조회
    @GetMapping("/auth/user")
    public ResponseEntity<?> searchUserByNickname(@RequestParam("search") String search){
        List<UserInfoRes> resultList = userService.searchUserByNickname(search);
        return new ResponseEntity<>(resultList, HttpStatus.OK);
    }

    // 닉네임, 프로필 이미지 조회
    @GetMapping("/auth/user/info")
    public ResponseEntity<?> getNicknameAndProfileImage(Authentication authentication){
        User auth = (User)authentication.getPrincipal();
        log.info("SecurityContextHolder 값 이용");
        System.out.println(auth.getUserUid() + " 닉네임 : " + auth.getNickname() + " 프로필 이미지 : " + auth.getProfileImageUrl());
        UserInfoRes result = userService.getNicknameAndProfileImage(auth.getUserUid());
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    // 소셜 로그인(카카오)
    @PostMapping("/login/kakao")
    public ResponseEntity<?> signUpKakao(@RequestBody UserLoginReq userLoginReq) throws Exception {
        System.out.println("컨트롤러 진입 " + userLoginReq.getAccessToken() + userLoginReq.getRefreshToken());
        TokenRes tokenRes = userService.signUpKakao(userLoginReq);
        return new ResponseEntity<>(tokenRes, HttpStatus.OK);
    }

    // 회원 정보 수정 (프로필 이미지 등)
    @PutMapping("/auth/user/info")
    public ResponseEntity<?> updateUser(){
        return null;
    }
}
