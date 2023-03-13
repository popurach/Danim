package com.danim.controller;

import com.danim.entity.TimeLine;
import com.danim.service.TimeLineService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;


@RequiredArgsConstructor
@RequestMapping("/api/auth/timeline")
@RestController
public class TimelineController {


    private final TimeLineService service;

    //메인피드 최신순 타임라인 조회
    @GetMapping("/main/{uid}")
    public ResponseEntity<?> getTimelineLatest(@PathVariable Long uid) throws Exception {

//        Account auth = (Account) authentication.getPrincipal();
//        Long tt = auth.getUid();
//        Member savedUser = memberservice.signup(member.getName(), member.getNickname(), tt);
        List<TimeLine> timelinelist = service.searchTimelineOrderBylatest(1L);
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "모든 최신 타임라인 리스트 얻어오기 성공");
            put("data", timelinelist);
        }}, HttpStatus.OK);
    }


    //내 피드에서 내 타임라인 리스트 조회 , 다른 유저의 피드에서 타임라인 조회
    @GetMapping("/mine")
    public ResponseEntity<?> getMyTimelineList() throws Exception {

        List<TimeLine> timelinelist = service.searchMyTimeline(1L);
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "멤버 가입성공");
            put("data", timelinelist);
        }}, HttpStatus.OK);
    }

    //다른 유저의 피드에서 타임라인 조회
    @GetMapping("/user/{uid}")
    public ResponseEntity<?> getAnotherTimelineList(@PathVariable Long uid) throws Exception {

        List<TimeLine> timelinelist = service.searchTimelineNotPublic(1L);
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "타멤버 Timeline얻어오기 성공");
            put("data", timelinelist);
        }}, HttpStatus.OK);
    }


    //타임라인 한개 조회
    @GetMapping("/{uid}")
    public ResponseEntity<?> seleteOneTimeLine(@PathVariable Long uid) throws Exception {
        //유저 한명을 받아 와서 해당 유저로 타임라인을 생성하고자 한다
        TimeLine timeline = service.searchOneTimeline(1L);
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("data", timeline);
            put("msg", "Timeline 완료 성공");
        }}, HttpStatus.OK);
    }

    //여행시작
    @PostMapping("")
    public ResponseEntity<?> makeTimeLine() throws Exception {
        //유저 한명을 받아 와서 해당 유저로 타임라인을 생성하고자 한다
        service.makenewTimeline(1L);
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "Timeline 생성성공");
        }}, HttpStatus.OK);
    }


    //여행끝
    @PutMapping("/{uid}")
    public ResponseEntity<?> finishTimeLine(@PathVariable Long uid) throws Exception {
        //유저 한명을 받아 와서 해당 유저로 타임라인을 생성하고자 한다
        service.finishTimeline(4L);
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "Timeline 완료 성공");
        }}, HttpStatus.OK);
    }

    //타임라인 공개 <->비공개 변경
    @PutMapping("/switch/{uid}")
    public ResponseEntity<?> changeTimeLinePublic(@PathVariable Long uid) throws Exception {
        //유저 한명을 받아 와서 해당 유저로 타임라인을 생성하고자 한다
        service.changePublic(3L);
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "Timeline Public 변경 성공");
        }}, HttpStatus.OK);
    }

    //타임라인삭제
    @DeleteMapping("/{uid}")
    public ResponseEntity<?> deleteTimeLine(@PathVariable Long uid) throws Exception {
        //유저 한명을 받아 와서 해당 유저로 타임라인을 생성하고자 한다
        service.deleteTimeline(1L);
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "Timeline 삭제 성공");
        }}, HttpStatus.OK);
    }


}
