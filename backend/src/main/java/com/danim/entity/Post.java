package com.danim.entity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

import org.hibernate.annotations.DynamicInsert;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.repository.cdi.Eager;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@DynamicInsert
public class Post extends BaseTime {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "post_id", nullable = false)
    private Long postId;

    private String voiceUrl;

    private Long voiceLength;

    private String nationUrl;

    private String address1;

    private String address2;

    private String address3;

    private String address4;

    private String text;

    // Post 테이블과 TimeLine 테이블 FK
    @ManyToOne
    @JoinColumn(name = "timeline_id")
    @ToString.Exclude
    private TimeLine timelineId;

    // Post 테이블과 Nation 테이블 FK
    @ManyToOne
    @JoinColumn(name = "nation_id")
    @ToString.Exclude
    private Nation nationId;

    @OneToMany(mappedBy = "postId", cascade = CascadeType.PERSIST, fetch = FetchType.EAGER)
    @Builder.Default
    private List<Photo> photoList = new ArrayList<>(); // photoId 리스트


}