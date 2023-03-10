package com.danim.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class User {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "userUid")
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
