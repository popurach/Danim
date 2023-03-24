package com.danim.dto;

import com.danim.entity.Photo;
import com.danim.entity.Post;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Builder(builderMethodName = "MyPostDtoBuilder")
@Getter
public class MyPostDto {

    private Long postId;

    private String voiceUrl;

    private Double voiceLength;


    private String address2;
    private String address3;
    private String address4;


    private String text;


    private List<Photo> photoList; // photoId 리스트


    public static MyPostDtoBuilder builder(Post post) {

        return MyPostDtoBuilder()
                .postId(post.getPostId())
                .voiceUrl(post.getVoiceUrl())
                .voiceLength(post.getVoiceLength())
                .address2(post.getAddress2())
                .address3(post.getAddress3())
                .address4(post.getAddress4())
                .text(post.getText())
                .photoList(post.getPhotoList())
                ;

    }

}
