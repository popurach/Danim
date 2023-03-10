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
    @Column(name = "user_uid")
    private Long user_uid;

    @Column(unique = true)
    private String nickname;

    @Column(unique = true, nullable = false)
    private String client_id;

    //@ApiModelProperty(hidden = true)
    private String role;

    private String refresh_token;


    private String profile_image_url;

}
