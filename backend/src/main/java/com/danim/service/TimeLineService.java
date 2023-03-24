package com.danim.service;

import com.danim.dto.MainTimelinePhotoDto;
import com.danim.dto.TimelinePostOuter;
import com.danim.entity.TimeLine;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface TimeLineService {

    //메인피드에서 최신순으로 조회=>완료
    List<TimeLine> searchTimelineOrderBylatest() throws Exception;

    //내 피드에서 내 타임라인 리스트 조회 ,
    List<TimeLine> searchMyTimeline(Long uid) throws Exception;

    //다른 유저의 피드에서 타임라인 조회도 가능
    List<TimeLine> searchTimelineNotPublic(Long uid) throws Exception;

    //타임라인 한개 조회=>완료
    TimelinePostOuter searchOneTimeline(Long uid) throws Exception;

    //여행시작 =>완료
    void makenewTimeline(Long uid) throws Exception;

    //여행끝 =>완료
    void finishTimeline(Long uid) throws Exception;

    //타임라인삭제=>우선 놔둠
    void deleteTimeline(Long uid) throws Exception;

    //타임라인 공개 <->비공개 변경 => 완료
    void changePublic(Long uid) throws Exception;


    //메인 피드상에서 타임라인 페이징 처리해서 조회하는 메서드
    List<MainTimelinePhotoDto> searchTimelineOrderBylatestPaging(Pageable pageable) throws Exception;

    //내타임라인 페이징 처리해서 조회
    List<MainTimelinePhotoDto> searchMyTimelineWithPaging(Long uid, Pageable pageable) throws Exception;

    //다른 유저의 피드에서 타임라인 조회 with Paging
    List<MainTimelinePhotoDto> searchTimelineNotPublicWithPaging(Long uid, Pageable pageable) throws Exception;


    //타임 라인 하나 불러올시에, 썸네일, 시작 위치 끝나는 위치,


}
