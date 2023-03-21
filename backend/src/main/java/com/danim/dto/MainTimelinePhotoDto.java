package com.danim.dto;

import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.entity.TimeLine;
import com.danim.entity.User;
import lombok.Builder;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Builder(builderMethodName = "MainTimelinePhotoDtoBuilder")
public class MainTimelinePhotoDto {

    //10개 정도를 넘겨 준다고 생각 하면됨

    //타임라인 id
    private Long timelineId;

    //썸네일
    private String url;

    //여행 제목
    private String title;

    //여행자 닉네임
    private String nickname;

    // =>여행기간 localdatetime으로 하면 안됨
    //여행 시작
    //ex)2019-11-13
    private String createTime;//생성시간

    //여행 마감
    private String finishTime;//완료시간


    //여행 시작 장소 ~ 여행 마감 장소 =>  추후에 정해야 함

    private String start_place;

    private String finish_place;

    public static String make(LocalDateTime date) {
        String s3 = date.toString();
        s3 = s3.replace("-", ".");
        return s3;
    }


    public static MainTimelinePhotoDtoBuilder builder(TimeLine timeline, Post post, Photo photo, User user) {

        String start = make(timeline.getCreateTime());
        String finish = make(timeline.getFinishTime());

        return MainTimelinePhotoDtoBuilder().
                timelineId(timeline.getTimelineId()).
                url(photo.getPhotoUrl())
                .title(timeline.getTitle())
                .nickname(user.getNickname())
                .createTime(start)
                .finishTime(finish)
                .start_place("시작이")
                .finish_place("끝남이");

    }

}
