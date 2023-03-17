package com.danim.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Comment extends BaseTime {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Long commentId;


    private String content;

    @ManyToOne
    @JoinColumn(name="post_id")
    private Post postId;

    @ManyToOne
    @JoinColumn(name="user_uid")
    private User userUid;

}
