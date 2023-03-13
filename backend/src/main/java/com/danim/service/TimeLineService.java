package com.danim.service;

import com.danim.entity.TimeLine;

import java.util.List;

public interface TimeLineService {

    //메인피드에서 최신순으로 조회
    List<TimeLine> searchTimelineOrderBylatest();

    //내 피드에서 내 타임라인 리스트 조회 , 다른 유저의 피드에서 타임라인 조회도 가능
    List<TimeLine> searchMyTimeline(Long uid);

    //타임라인 한개 조회
    TimeLine searchOneTimeline(Long uid);

    //여행시작
    void newTimeline(Long uid);

    //여행끝
    void finishTimeline(Long uid);

    //타임라인삭제

    void deleteTimeline(Long uid);


}
