package com.danim.dto;

import com.danim.entity.Post;
import lombok.Builder;

@Builder(builderMethodName = "GetPostResBuilder")
public class GetPostRes {
    private Long timelineId;
    private String thumbNail;

    public static GetPostRes.GetPostResBuilder builder(Post post) {
        Long timelineId = post.getTimelineId().getTimelineId();
        String thumbNail = post.getPhotoList().get(0).getPhotoUrl();

        return GetPostResBuilder()
                .timelineId(timelineId)
                .thumbNail(thumbNail);
    }
}
