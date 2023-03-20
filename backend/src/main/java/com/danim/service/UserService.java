package com.danim.service;

import com.danim.entity.UserDetails;

public interface UserService {

    void makeUser();

    UserDetails loadUserByUsername(String clientId) throws Exception;
}
