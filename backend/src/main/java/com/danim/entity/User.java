package com.danim.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long userUid;

    private String nickname;

    @Column(unique = true, nullable = false)
    private String clientId;

    //@ApiModelProperty(hidden = true)
    private String role;

    private String refreshToken;

    private String profileImageUrl;

    private String password;

    // 계정이 가지고 있는 권한 목록을 리턴
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority((this.getRole())));
        return authorities;
    }

    @Override
    public String getPassword() {
        return this.password;
    }
    // 계정의 clientId 리턴
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Override
    public String getUsername() {
        return this.nickname;
    }
//    // 계정이 만료됐는지 리턴. true는 만료되지 않았다는 의미
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
//    // 계정이 잠겨있는지 리턴. true는 잠기지 않았다는 의미
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
//    // 비밀번호가 만료됐는지 리턴. true는 만료되지 않았다는 의미
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
//    // 계정이 활성화돼 있는지 리턴. true는 활성화 상태를 의미
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Override
    public boolean isEnabled() {
        return true;
    }
//    @Builder
//    public User(Long userUid, String nickname, String clientId) {
//        this.userUid = userUid;
//        this.nickname = nickname;
//        this.clientId = clientId;
//    }
//    void TestUser(Long userUid, String nickname, String clientId){
//        this.userUid = userUid;
//        this.nickname = nickname;
//        this.clientId = clientId;
//    }

}
