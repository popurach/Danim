package com.danim.controller;

import com.danim.entity.TimeLine;
import com.danim.entity.User;
import com.danim.service.TimeLineService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;


@RequiredArgsConstructor
@RequestMapping("/api/auth/user")
@RestController
public class UserController {


    private final TimeLineService service;

    //메인피드 최신순 타임라인 조회
    @GetMapping("/main")
    public ResponseEntity<?> getTimelineLatest(@RequestBody TimeLine timeline, final Authentication authentication) throws Exception {

//        Account auth = (Account) authentication.getPrincipal();
//        Long tt = auth.getUid();
//        Member savedUser = memberservice.signup(member.getName(), member.getNickname(), tt);

        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "멤버 가입성공");
        }}, HttpStatus.OK);
    }






}
