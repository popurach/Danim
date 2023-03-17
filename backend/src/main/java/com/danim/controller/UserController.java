package com.danim.controller;
import com.danim.entity.User;
import com.danim.service.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping
@Slf4j
public class UserController {
    private final UserServiceImpl userServiceImpl;
    @PostMapping("/user")
    public ResponseEntity<?> insertUser(@RequestBody User user){
        User response = userServiceImpl.insertUser(User.builder().userUid(user.getUserUid()).nickname(user.getNickname()).clientId(user.getClientId()).build());
        log.info("insertUser : ",response);
        return ResponseEntity.ok(response);
    }
}
