package com.danim.service;

import com.danim.entity.User;
import org.springframework.security.core.userdetails.UserDetails;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
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

    }

    @Override
    public User loadUserByUsername(String clientId) throws Exception {
//        log.info("[loadUserByUsername] loadUserByUsername 수행. username : {}", username);
        return userRepository.getByClientId(clientId);
    }
}
