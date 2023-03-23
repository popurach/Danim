package com.danim.controller;
import com.amazonaws.Response;
import com.danim.dto.UserLoginReq;
import com.danim.entity.User;
import com.danim.service.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.danim.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;
//import org.json.JSONObject;


import java.util.HashMap;


@RequestMapping("/api")
@RestController
@Slf4j
public class UserController {


    private final UserService userService;

    @Autowired
    public UserController(UserService userService){
        this.userService = userService;
    }
//    @PostMapping("/user")
//    public ResponseEntity<?> insertUser(@RequestBody User user){
//        User response = userServiceImpl.insertUser(User.builder().userUid(user.getUserUid()).nickname(user.getNickname()).build());
//        log.info("insertUser : ",response);
//        return ResponseEntity.ok(response);
//    }
    //메인피드 최신순 타임라인 조회
//    @PostMapping("")
//    public ResponseEntity<?> makenewuser() throws Exception {
//
//        service.makeUser();
//
//        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
//            put("result", true);
//            put("msg", "User 가입성공");
//        }}, HttpStatus.OK);
//    }

    //  닉네임 중복 체크
    @GetMapping("/auth/user/{nickname}")
    public ResponseEntity<?> duplicateCheck(@PathVariable String nickname){
        return null;
    }

    // 유저 조회
    @GetMapping("/auth/user")
    public ResponseEntity<?> searchUserByNickname(@RequestParam("search") String search){
        return null;
    }

    // 닉네임, 프로필 이미지 조회
//    @GetMapping("")
//    public ResponseEntity<?> getNicknameAndProfileImage(){
//
//    }

    // 소셜 로그인(구글)
//    @PostMapping("/google")
//    public ResponseEntity<?> signUpGoogle(){
//
//    }

    // 소셜 로그인(네이버)
    @PostMapping("/login/naver")
    public ResponseEntity<?> signUpNaver(@RequestBody UserLoginReq userLoginReq){
        userService.signUpNaver(userLoginReq);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    // 소셜 로그인(카카오)
//    @PostMapping("/kakao")
//    public ResponseEntity<?> signUpGoogle(){
//
//    }

    // 회원 정보 수정 (프로필 이미지 등)
//    @PutMapping("/user")
//    public ResponseEntity<?> updateUser(){
//
//    }
}
