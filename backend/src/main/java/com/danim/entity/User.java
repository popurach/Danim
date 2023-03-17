package com.danim.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
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



}
