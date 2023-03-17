package com.danim.service;

import com.danim.entity.User;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
<<<<<<< HEAD
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{
    private final UserRepository userRepository;
    @Override
    public User insertUser(User user) {
        return userRepository.save(user);
=======
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    @Override
    public void makeUser() {
        User u = new User();
        u.setClientId("22");
        userRepository.save(u);

>>>>>>> f2b77618a47877d9c644d5feabe2787e530925e2
    }
}
