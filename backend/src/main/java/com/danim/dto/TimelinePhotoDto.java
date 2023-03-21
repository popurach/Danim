package com.danim.dto;

import java.time.LocalDateTime;

public class TimelinePhotoDto {

    //타임라인 id
    private Long timelineId;

    //썸네일


    //여행 제목
    private String title;

    //여행자 닉네임
    private String nickname;


    // =>여행기간 localdatetime으로 하면 안됨

    //여행 시작
    private LocalDateTime createTime;//생성시간

    //여행 마감
    private LocalDateTime finishTime;//완료시간


    //여행 시작 장소 ~ 여행 마감 장소


}
