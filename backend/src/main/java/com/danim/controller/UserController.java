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
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.danim.service.UserService;
import org.springframework.http.HttpStatus;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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
    public ResponseEntity<?> getNicknameAndProfileImage(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        System.out.println("auth.getPrincipal : " + auth.getPrincipal());//com.danim.enitity.user
        System.out.println("auth.getDetails : " + auth.getDetails());
        System.out.println("auth.getClass : " + auth.getClass());
        System.out.println("auth.getCredentials : " + auth.getCredentials());
        System.out.println("auth.getName : " + auth.getName());

        if(auth != null && auth.getPrincipal() != null){
            User user = (User)auth.getPrincipal();
            UserInfoRes result = UserInfoRes.builder()
                    .userUid(user.getUserUid())
                    .nickname(user.getNickname())
                    .profileImageUrl(user.getProfileImageUrl())
                    .build();
            return new ResponseEntity<>(result, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    // 소셜 로그인(카카오)
    @PostMapping("/login/kakao")
    public ResponseEntity<?> signUpKakao(@RequestBody UserLoginReq userLoginReq) throws Exception {
        TokenRes tokenRes = userService.signUpKakao(userLoginReq);
        return new ResponseEntity<>(tokenRes, HttpStatus.OK);
    }

    // 회원 정보 수정 (프로필 이미지)
    @PutMapping("/auth/user/info")
    public ResponseEntity<?> updateUser(@RequestPart MultipartFile profileImage) throws Exception {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if(auth != null && auth.getPrincipal() != null) {
            User user = (User) auth.getPrincipal();
            UserInfoRes userInfoRes = userService.updateUserInfo(user.getUserUid(), profileImage);
            return new ResponseEntity<>(userInfoRes, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
