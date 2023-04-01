package com.danim.entity;

import lombok.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@DynamicInsert
public class Post extends BaseTime{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "post_id", nullable = false)
	private Long postId;
	
	private String voiceUrl;
	
	private Double voiceLength;
	
	private String nationUrl;
	
	private String address1;
	private String address2;
	private String address3;
	private String address4;

	private String text;

	// Post 테이블과 TimeLine 테이블 FK
	@ManyToOne
	@JoinColumn(name="timeline_id")
	@ToString.Exclude
	@OnDelete(action = OnDeleteAction.CASCADE)
	private TimeLine timelineId;

	// Post 테이블과 Nation 테이블 FK
	@ManyToOne
	@JoinColumn(name="nation_id")
	@ToString.Exclude

	private Nation nationId;

	@OneToMany(mappedBy = "postId",fetch = FetchType.EAGER)
	@Builder.Default
	@OnDelete(action = OnDeleteAction.CASCADE)
	private List<Photo> photoList = new ArrayList<>(); // photoId 리스트
}