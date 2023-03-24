package com.danim.service;

import com.danim.config.security.JwtTokenProvider;
import com.danim.dto.UserLoginReq;
import com.danim.dto.TokenRes;
import com.danim.dto.UserInfoRes;
import com.danim.entity.User;
import com.danim.repository.UserRepository;
import com.danim.utils.HttpUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.transaction.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    public JwtTokenProvider jwtTOkenProvider;
    public PasswordEncoder passwordEncoder;

//    @Autowired
//    public UserServiceImpl(UserRepository userRepository, @Lazy JwtTokenProvider jwtTokenProvider, @Lazy PasswordEncoder passwordEncoder){
//        this.userRepository = userRepository;
//        this.jwtTOkenProvider = jwtTokenProvider;
//        this.passwordEncoder = passwordEncoder;
//    }
    @Override
    public User loadUserByUsername(String clientId) throws Exception {
//        log.info("[loadUserByUsername] loadUserByUsername 수행. username : {}", username);
        return userRepository.getByClientId(clientId);
    }

    @Override
    public List<UserInfoRes> searchUserByNickname(String search) {
        List<UserInfoRes> result = userRepository.searchUserByNickname(search);
        return result;
    }

    @Override
    public UserInfoRes getNicknameAndProfileImage(Long userUid) {
        UserInfoRes result = userRepository.getNicknameAndProfileImage(userUid);
        return result;
    }

    // 카카오 로그인 연동
    public TokenRes signUpKakao(UserLoginReq userLoginReq) throws JsonProcessingException {
        // 카카오톡 rest api (id, profile image, nickname)
        HttpHeaders headers = HttpUtil.generateHttpHeadersForJWT(userLoginReq.getAccessToken());
        RestTemplate restTemplate = HttpUtil.generateRestTemplate();

        HttpEntity<String> request = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.GET, request, String.class);

        JsonNode json = new ObjectMapper().readTree(response.getBody());

        String clientId = json.get("id").asText();
        String profileImageUrl = json.get("kakao_account").get("profile").get("profile_image_url").asText();
        String nickname = json.get("kakao_account").get("profile").get("profile_image_url").asText();

        // 카카오에서 받아 온 데이터로 이미 등록된 유저인지 확인
        User user;

        if(userRepository.getByClientId(clientId) != null){
            user = userRepository.getByClientId(clientId);
            if(!passwordEncoder.matches("다님", user.getPassword())){
                throw new RuntimeException();
            }
            return jwtTOkenProvider.recreateToken(user.getClientId(), "USER", user.getRefreshToken());
        }

        // 미등록 사용자
        TokenRes tokenRes = jwtTOkenProvider.createtoken(clientId, "USER");

        user = User.builder()
                .nickname(nickname) // 'nickname' 값을 nickname에 저장
                .clientId(clientId) // 'id' 값을 clientId에 저장
                .role("USER")
                .refreshToken(tokenRes.getRefreshToken())
                .profileImageUrl("")
                .password(passwordEncoder.encode("다님"))
                .build();
        User savedUser = userRepository.save(user);
        return tokenRes;
    }

}
