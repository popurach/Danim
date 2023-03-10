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
public class Post extends BaseTime{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "post_id", nullable = false)
	private Long postId;
	
	@Column(name = "voice_url")
	private String voiceUrl;
	
	@Column(name = "voice_length")
	private Long voiceLength;
	
	@Column(name = "nation_url")
	private String nationUrl;
	
	private String address;
	
	private String text;

	@ManyToOne
	@JoinColumn(name="timeline_id")
	@ToString.Exclude
	private Post timelineId;

//	@ManyToOne
//	@JoinColumn(name="nation_id")
//	@ToString.Exclude
//	private Nation nationid;

	@OneToMany(
			mappedBy = "postId"
	)
	@Builder.Default //
	private List<Photo> photoList = new ArrayList<>(); // photoId 리스트

	@OneToMany(
			mappedBy = "postId"
	)
	@Builder.Default
	private List<Image> imageList = new ArrayList<>(); // image 리스트
}