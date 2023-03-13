package com.danim.entity;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Photo {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "photoId", nullable = false)
    private Long photoId;

    @Column(unique = true, nullable = false)
    private String photoUrl;

    private double lat;

    private double lng;

    @Builder.Default
    @ColumnDefault("0")
    private Boolean isLive = false;

    @ManyToOne
    @JoinColumn(name="post_id")
    private Post postId;
}
