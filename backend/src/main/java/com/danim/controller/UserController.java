package com.danim.controller;
import com.danim.dto.TokenRes;
import com.danim.dto.UserLoginReq;
import com.danim.dto.UserInfoRes;
import com.danim.entity.User;
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
        UserInfoRes result = userService.getNicknameAndProfileImage(auth.getUserUid());
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    // 소셜 로그인(네이버)
    @PostMapping("/login/naver")
    public ResponseEntity<?> signUpNaver(@RequestBody UserLoginReq userLoginReq){
        TokenRes tokenRes = userService.signUpNaver(userLoginReq);
        return new ResponseEntity<>(tokenRes, HttpStatus.OK);
    }

    // 회원 정보 수정 (프로필 이미지 등)
    @PutMapping("/auth/user/info")
    public ResponseEntity<?> updateUser(){
        return null;
    }
}
