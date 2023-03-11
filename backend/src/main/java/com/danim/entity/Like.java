package com.danim.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Like {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Long likeId;

    @ManyToOne
    @JoinColumn(name="post_id")
    private Post postId;

    @ManyToOne
    @JoinColumn(name="user_id")
    private User userUid;
}
