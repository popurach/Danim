package com.danim.service;

import com.danim.dto.TokenRes;
import com.danim.dto.UserLoginReq;
import com.danim.entity.User;

public interface UserService {
    User loadUserByUsername(String clientId) throws Exception;

    public TokenRes signUpNaver(UserLoginReq userLoginReq);

}
