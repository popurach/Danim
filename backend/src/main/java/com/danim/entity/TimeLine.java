package com.danim.entity;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@DynamicInsert //@DynamicInsert사용
@Builder

public class TimeLine extends BaseTime {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Long timelineId;

    @Column(name = "title", nullable = false)
    @Builder.Default
    @ColumnDefault("'여행중'")
    private String title = "여행중";


    @Builder.Default
    @ColumnDefault("0")
    private Boolean complete = false;


    @Builder.Default
    @ColumnDefault("1")
    private Boolean timelinePublic = true;


    private LocalDateTime finishTime;//완료시간


    //not null그대로 가져와야함.....
    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.DETACH)
    @JoinColumn(name = "user_uid", nullable = false)
    @ToString.Exclude
    private User userUid;


}

