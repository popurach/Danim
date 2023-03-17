package com.danim.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long userUid;

    @Column(unique = true)
    private String nickname;

    @Column(unique = true, nullable = false)
    private String clientId;

    //@ApiModelProperty(hidden = true)
    private String role;

    private String refreshToken;

    private String profileImageUrl;

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
