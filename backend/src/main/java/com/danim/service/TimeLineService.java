package com.danim.service;

import com.danim.entity.TimeLine;

import java.util.List;

public interface TimeLineService {

    //메인피드에서 최신순으로 조회=>완료
    List<TimeLine> searchTimelineOrderBylatest(Long uid) throws Exception;

    //내 피드에서 내 타임라인 리스트 조회 , 다른 유저의 피드에서 타임라인 조회도 가능=>완료
    List<TimeLine> searchMyTimeline(Long uid) throws Exception;

    //타임라인 한개 조회=>완료
    TimeLine searchOneTimeline(Long uid) throws Exception;

    //여행시작 =>완료
    void makenewTimeline(Long uid) throws Exception;

    //여행끝 =>완료
    void finishTimeline(Long uid) throws Exception;

    //타임라인삭제=>우선 놔둠
    void deleteTimeline(Long uid) throws Exception;

    //타임라인 공개 <->비공개 변경 => 완료
    void changePublic(Long uid) throws Exception;


}
