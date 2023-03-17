package com.danim.service;

import com.danim.entity.User;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{
    private final UserRepository userRepository;
    @Override
    public User insertUser(User user) {
        return userRepository.save(user);
    }
}
