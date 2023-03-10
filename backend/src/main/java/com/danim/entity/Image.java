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

public class Image {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "imageId")
    private Long imageId;


    @Column(unique = true, nullable = false)
    private String imageUrl;

    @ManyToOne
    @JoinColumn(name="post_id")
    private Post postId;
}
