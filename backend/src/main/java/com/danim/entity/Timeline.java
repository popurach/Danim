package com.danim.entity;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Timeline {





    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Long timeline_id;

    @Column(name = "title",nullable = false)
    //@ColumnDefault("journey") //@ColumnDefault사용
    private String title="여행중";


    @CreationTimestamp
    private LocalDateTime create_time;

    @UpdateTimestamp
    private LocalDateTime modify_time;

    @CreationTimestamp
    private LocalDateTime finish_time;


    private Boolean complete=false;


    private Boolean t_public=true;

    @ManyToOne(targetEntity = User.class)
    @JoinColumn(name="user_uid")
    @ToString.Exclude
    private Long user_uid;


}
