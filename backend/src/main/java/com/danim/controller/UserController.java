package com.danim.controller;

import com.danim.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;


@RequiredArgsConstructor
@RequestMapping("/api/auth/user")
@RestController
public class UserController {


    private final UserService service;

    //메인피드 최신순 타임라인 조회
    @PostMapping("")
    public ResponseEntity<?> makenewuser() throws Exception {

        service.makeUser();

        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "User 가입성공");
        }}, HttpStatus.OK);
    }






}
