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
    @Column(name="user_uid")
    private Long user_uid;

    @Column(unique=true)
    String nickname;

    @Column(unique=true , nullable = false)
    String client_id;

    //@ApiModelProperty(hidden = true)
    String role;

    String refresh_token;


    String profile_image_url;

}
