package com.danim.service;

import com.danim.config.security.JwtTokenProvider;
import com.danim.dto.UserLoginReq;
import com.danim.dto.TokenRes;
import com.danim.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

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
    public User loadUserByUsername(String nickname) throws Exception {
//        log.info("[loadUserByUsername] loadUserByUsername 수행. username : {}", username);
        return userRepository.getByNickname(nickname);
    }

    // 네이버 로그인 연동
    @Override
    public TokenRes signUpNaver(UserLoginReq userLoginReq) {
        // 토큰을 이용하여 네이버 브라우저에서 유저 정보 받아오기 ()
        String token = userLoginReq.getAccessToken(); // 네이버 로그인 접근 토큰
        String header = "Bearer " + token; // Bearer 다음에 공백 추가

        String apiURL = "https://openapi.naver.com/v1/nid/me";
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Authorization", header);
        String responseBody = getNaver(apiURL,requestHeaders);

        // response 안에 있는 id 값을 clientId에 저장
        System.out.println("네이버 로그인 responseBody");
        System.out.println(responseBody);

        User user;
        // 네이버에서 받아 온 닉네임으로 이미 등록된 유저인지 확인
        if(userRepository.getByNickname(responseBody) != null){
            user = userRepository.getByNickname(responseBody);
            if(!passwordEncoder.matches("다님", user.getPassword())){
                throw new RuntimeException();
            }
            return jwtTOkenProvider.recreateToken(user.getNickname(), "USER", user.getRefreshToken());
        }

        // 미등록 사용자
        TokenRes tokenRes = jwtTOkenProvider.createtoken(responseBody, "USER");

        user = User.builder()
                .nickname(responseBody) // 'nickname' 값을 nickname에 저장
                .clientId(responseBody) // 'id' 값을 clientId에 저장
                .role("USER")
                .refreshToken(tokenRes.getRefreshToken())
                .profileImageUrl("")
                .password(passwordEncoder.encode("다님"))
                .build();
        User savedUser = userRepository.save(user);
        return tokenRes;
    }

    private static String getNaver(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 에러 발생
                return readBody(con.getErrorStream());
            }
        } catch (Exception e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }

    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }

}
