package com.danim.controller;

import com.danim.service.RestJsonService;
import com.danim.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.json.JSONObject;

import java.util.HashMap;


@RequiredArgsConstructor
@RequestMapping("/api/auth/user")
@RestController
public class UserController {


    private final UserService service;
    private final RestJsonService restJsonService;

    //메인피드 최신순 타임라인 조회
    @PostMapping("")
    public ResponseEntity<?> makenewuser() throws Exception {

        service.makeUser();

        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "User 가입성공");
        }}, HttpStatus.OK);
    }


    @GetMapping("/kakaotest")
//    public ResponseEntity<?> receiveAC(@RequestParam("code") String code, Model model) throws Exception {
    public ResponseEntity<?> receiveAC() throws Exception {
        //access_token이 포함된 JSON String을 받아온다.
        String accessTokenJsonData = restJsonService.getAccessTokenJsonData("1234");

        //JSON String -> JSON Object
        JSONObject accessTokenJsonObject = new JSONObject(accessTokenJsonData);

        //access_token 추출
        String accessToken = accessTokenJsonObject.get("access_token").toString();

        //model.addAttribute("access_token", accessToken);

        //... 생략
        return new ResponseEntity<Object>(new HashMap<String, Object>() {{
            put("result", true);
            put("msg", "카카오 로그인 성공");
            //put("data",model);
        }}, HttpStatus.OK);
    }


}
