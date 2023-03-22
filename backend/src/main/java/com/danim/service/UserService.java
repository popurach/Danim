package com.danim.service;

import com.danim.entity.User;
import com.danim.entity.UserDetails;

public interface UserService {

    void makeUser();

    User loadUserByUsername(String clientId) throws Exception;
}
