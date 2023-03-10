package com.danim.entity;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

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
    private Long timeline_id;

    //@Column(name = "title", nullable = false, columnDefinition = "varchar(255) default '여행중' ")
//    @Builder.Default
//    @ColumnDefault("'여행중'")

    @Column(name = "title", nullable = false, columnDefinition = "varchar(255) default '여행중' ")
    private String title = "여행중";


    //@Column(name = "complete",columnDefinition ="TINYINT(1) default 0 ")
    @Builder.Default
    @ColumnDefault("0")
    private Boolean complete = false;


    //@Column(name = "timeline_public",columnDefinition ="TINYINT(1) default 1 ")
    @Builder.Default
    @ColumnDefault("1")
    private Boolean timeline_public = true;


    //not null그대로 가져와야함.....
    @ManyToOne(targetEntity = User.class, fetch = FetchType.LAZY, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "user_uid", nullable = false)
    @ToString.Exclude
    private Long user_uid;


}
