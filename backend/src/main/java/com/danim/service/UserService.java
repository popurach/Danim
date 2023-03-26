package com.danim.service;

import com.danim.dto.TokenRes;
import com.danim.dto.UserLoginReq;
import com.danim.dto.UserInfoRes;
import com.danim.entity.User;
import com.fasterxml.jackson.core.JsonProcessingException;

import java.util.List;

public interface UserService {
    // 유저 조회
    List<UserInfoRes> searchUserByNickname(String search);

    // 닉네임, 프로필 이미지 조회
    UserInfoRes getNicknameAndProfileImage(Long userUid);

    TokenRes signUpKakao(UserLoginReq userLoginReq) throws JsonProcessingException;

}
