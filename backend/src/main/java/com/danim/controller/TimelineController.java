package com.danim.controller;

import com.danim.entity.TimeLine;
import com.danim.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import com.danim.service.TimeLineService;


import java.util.HashMap;


@RequiredArgsConstructor
@RequestMapping("/api/auth/timeline")
@RestController
public class TimelineController {


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


    //내 피드에서 내 타임라인 리스트 조회 , 다른 유저의 피드에서 타임라인 조회
    @GetMapping("/mine")
    public ResponseEntity<?> getMyTimelineList(@RequestBody TimeLine timeline, final Authentication authentication) throws Exception {


        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "멤버 가입성공");
        }}, HttpStatus.OK);
    }

    //타임라인 한개 조회


    //여행시작
    @PostMapping()
    public ResponseEntity<?> getMyTimelineList(@RequestBody User user) throws Exception {

        //유저 한명을 받아 와서 해당 유저로 타임라인을 생성하고자 한다


        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "멤버 가입성공");
        }}, HttpStatus.OK);
    }

    //여행끝


    //타임라인삭제


}
