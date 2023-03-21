package com.danim.dto;

import com.danim.entity.Nation;
import com.danim.entity.Photo;
import com.danim.entity.TimeLine;
import com.danim.entity.User;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Builder(builderMethodName = "MyPostDtoBuilder")
@Getter
public class MyPostDto {

    private Long postId;

    private String voiceUrl;

    private Long voiceLength;

    private String nationUrl;

    private String address1;

    private String text;

    private TimeLine timelineId;

    private Nation nationId;

    private List<Photo> photoList = new ArrayList<>(); // photoId 리스트

    private List<String> nationlist;
    private List<Integer> nationIndex;


//    public static MyPostDto builder(TimeLine timeline, Photo photo, User user) {
//
//        String start = "";
//        String finish = "";
//        if (timeline.getFinishTime() != null) {
//            start = make(timeline.getCreateTime());
//        }
//
//        if (timeline.getFinishTime() != null) {
//            finish = make(timeline.getFinishTime());
//        }
//
//
//        return MainTimelinePhotoDtoBuilder().
//                timelineId(timeline.getTimelineId()).
//                url(photo.getPhotoUrl())
//                .title(timeline.getTitle())
//                .nickname(user.getNickname())
//                .createTime(start)
//                .finishTime(finish)
//                .startPlace("시작이")
//                .finishPlace("끝남이");
//
//    }

}
