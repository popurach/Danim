package com.danim.controller;

import com.danim.entity.User;
import com.danim.service.UserService;
import com.danim.service.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;


@RequiredArgsConstructor
@RequestMapping("/api/auth/user")
@RestController
@Slf4j
public class UserController {


    private final UserService service;
    private final UserServiceImpl userServiceImpl;
    @PostMapping("/user")
    public ResponseEntity<?> insertUser(@RequestBody User user){
        User response = userServiceImpl.insertUser(User.builder().userUid(user.getUserUid()).nickname(user.getNickname()).clientId(user.getClientId()).build());
        log.info("insertUser : ",response);
        return ResponseEntity.ok(response);
    }
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
