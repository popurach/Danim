package com.danim.service;

import com.danim.config.security.JwtTokenProvider;
import com.danim.conponent.AwsS3;
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
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    public final JwtTokenProvider jwtTokenProvider;
    public final PasswordEncoder passwordEncoder;
    private final AwsS3 awsS3;

    @Override
    public List<UserInfoRes> searchUserByNickname(String search) {
        List<User> resultList = userRepository.searchUserByNickname(search);
        List<UserInfoRes> returnList = new ArrayList<>();

        for (User user : resultList){
            returnList.add(entityToResponseDTO(user));
        }
        return returnList;
    }

    // 카카오 로그인 연동
    public TokenRes signUpKakao(UserLoginReq userLoginReq) throws JsonProcessingException {
        // 카카오톡 rest api (id, profile image, nickname)
//        HttpHeaders headers = HttpUtil.generateHttpHeadersForJWT(userLoginReq.getAccessToken());
//        RestTemplate restTemplate = HttpUtil.generateRestTemplate();
//
//        HttpEntity<String> request = new HttpEntity<>(headers);
//        ResponseEntity<String> response = restTemplate.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.GET, request, String.class);
//
//        JsonNode json = new ObjectMapper().readTree(response.getBody());
//
//        String clientId = json.get("id").asText();
//        String profileImageUrl = json.get("kakao_account").get("profile").get("profile_image_url").asText();
//        String nickname = json.get("kakao_account").get("profile").get("nickname").asText();

        // 카카오에서 받아 온 데이터(clientId)로 이미 등록된 유저인지 확인
        User user;
        String clientId = "1234";
        String nickname = "이영차";
        String profileImageUrl = "http://k.kakaocdn.net/dn/rkzVf/btrJlo4CzEH/nF4GlVkeOKaU7HSYw0k1aK/img_640x640.jpg";

        if(userRepository.getByClientId(clientId) != null){
            user = userRepository.getByClientId(clientId);
            if(!passwordEncoder.matches("다님", user.getPassword())){
                throw new RuntimeException();
            }
            return jwtTokenProvider.recreateToken(user.getClientId(), "USER", user.getRefreshToken());
        }

        // 미등록 사용자
        System.out.println("토큰 provider 실행 !!!");
        TokenRes tokenRes = jwtTokenProvider.createtoken(clientId, "USER");
        System.out.println("토큰 생성 !!!!");
        user = User.builder()
                .nickname(nickname) // 'nickname' 값을 nickname에 저장
                .clientId(clientId) // 'id' 값을 clientId에 저장
                .role("USER")
                .refreshToken(tokenRes.getRefreshToken())
                .profileImageUrl(profileImageUrl)
                .password(passwordEncoder.encode("다님"))
                .build();
        User savedUser = userRepository.save(user);
        return tokenRes;
    }

    @Override
    public UserInfoRes updateUserInfo(Long userUid, MultipartFile profileImage) throws Exception {
        // 프로필 이미지 S3에 업로드 및 imageURL 가져오기
        String ProfileImageUrl = awsS3.upload(profileImage, "Danim/profile");

        User user = userRepository.getByUserUid(userUid);

        // 이전 프로필 이미지 Url -> s3에서 삭제
        String beforeProfileImageUrl = user.getProfileImageUrl();
        awsS3.delete(beforeProfileImageUrl);
        user.setProfileImageUrl(ProfileImageUrl);
        return entityToResponseDTO(user);
    }

    // User 객체를 UserInfoRes로 변환
    private UserInfoRes entityToResponseDTO(User user){
        return UserInfoRes.builder()
                .userUid(user.getUserUid())
                .nickname(user.getNickname())
                .profileImageUrl((user.getProfileImageUrl()))
                .build();
    }
}
