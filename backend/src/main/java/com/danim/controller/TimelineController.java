package com.danim.controller;

import com.danim.dto.MainTimelinePhotoDtoRes;
import com.danim.dto.TimelinePostOuter;
import com.danim.entity.User;
import com.danim.service.TimeLineService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RequiredArgsConstructor
@RequestMapping("/api/auth/timeline")
@RestController
@Log4j2
public class TimelineController {

    private final TimeLineService timeLineService;

//    //메인피드 최신순 타임라인 조회
//    @GetMapping("/main")
//    public ResponseEntity<?> getTimelineLatest() throws Exception {
//
//        log.info("메인피드 최신수 타임라인 조회 시작");
//        List<TimeLine> timelinelist = timeLineService.searchTimelineOrderBylatest();
//        log.info("메인피드 최신수 타임라인 조회 종료");
//        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
//
//    }
//
//    //내 피드에서 내 타임라인 리스트 조회
//    @GetMapping("/mine/{uid}")
//    public ResponseEntity<?> getMyTimelineList(@PathVariable Long uid) throws Exception {
//
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        User user = null;
//        if (auth != null && auth.getPrincipal() != null)
//            user = (User) auth.getPrincipal();
//
//        log.info("내 피드에서 내 타임라인 리스트 조회");
//        List<TimeLine> timelinelist = timeLineService.searchMyTimeline(uid, user);
//        log.info("내 피드에서 내 타임라인 리스트 조회 종료");
//        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
//    }
//
//    //다른 유저의 피드에서 타임라인 조회
//    @GetMapping("/user/{uid}")
//    public ResponseEntity<?> getAnotherTimelineList(@PathVariable Long uid) throws Exception {
//        log.info("다른 유저의 피드에서 타임라인 조회 시작");
//        List<TimeLine> timelinelist = timeLineService.searchTimelineNotPublic(uid);
//        log.info("다른 유저의 피드에서 타임라인 조회 종료");
//        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
//    }


    //타임라인 한개 조회 => 이제 이걸 해야함 , 넘겨줄때 여행한 국가 리스트 순서대로 해서 만들어 넘겨주면 될듯
    @GetMapping("/{uid}")
    public ResponseEntity<?> seleteOneTimeLine(@PathVariable Long uid) throws Exception {
        log.info("타임라인 한개 조회 시작");
        TimelinePostOuter timeline = timeLineService.searchOneTimeline(uid);
        log.info("타임라인 한개 조회 종료");
        return new ResponseEntity<>(timeline, HttpStatus.OK);
    }

    //여행시작 , 여기에는 사용자 를 구분할수 있는 requestbody가 필요하다
    @PostMapping("")
    public ResponseEntity<?> makeTimeLine() throws Exception {
        //유저 한명을 받아 와서 해당 유저로 타임라인을 생성하고자 한다
        log.info("여행 시작 기능 시작");

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = null;
        if (auth != null && auth.getPrincipal() != null)
            user = (User) auth.getPrincipal();
        timeLineService.makenewTimeline(user);
        log.info("여행 시작 기능 종료");
        return new ResponseEntity<>(HttpStatus.OK);
    }


    //여행끝
    @PutMapping("/{uid}")
    public ResponseEntity<?> finishTimeLine(@PathVariable Long uid) throws Exception {
        log.info("여행종료 기능 시작");
        timeLineService.finishTimeline(uid);
        log.info("여행종료 기능 완료");
        return new ResponseEntity<>(HttpStatus.OK);
    }

    //타임라인 공개 <->비공개 변경
    @PutMapping("/switch/{uid}")
    public ResponseEntity<?> changeTimeLinePublic(@PathVariable Long uid) throws Exception {
        log.info("타임라인 공개<->비공개 전환 시작");
        timeLineService.changePublic(uid);
        log.info("타임라인 공개<->비공개 전환 종료");
        return new ResponseEntity<>(HttpStatus.OK);
    }

    //타임라인삭제
    @DeleteMapping("/{uid}")
    public ResponseEntity<?> deleteTimeLine(@PathVariable Long uid) throws Exception {
        log.info("타임라인 삭제 기능 시작");
        timeLineService.deleteTimeline(uid);
        log.info("타임라인 삭제 기능 종료");
        return new ResponseEntity<>(HttpStatus.OK);
    }


    /*paging  하는 메서드들*/


    //메인피드 최신순 타임라인 조회 with paging +
    //어떤 유저로 받을지는 파라미터에 추가가 되어야 함
    //sort="id", direction = Sort.Direction.DESC
    @GetMapping("/main/{page}")//테스트 해보기
    public ResponseEntity<?> getTimelineLatestWithPaging(@PathVariable Integer page) throws Exception {
        log.info("메인피드 최신순 타임라인 조회 시작");
        Pageable pageable = PageRequest.of(page, 3, Sort.by("createTime").descending());
        List<MainTimelinePhotoDtoRes> timelinelist = timeLineService.searchTimelineOrderBylatestPaging(pageable);
        log.info("메인피드 최신순 타임라인 조회 종료");
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
    }


    //내 피드에서 내 타임라인 리스트 조회 with paging =>테스트 해보기
    @GetMapping("/mine/{page}")
    public ResponseEntity<?> getMyTimelineListWithPaging(@PathVariable Integer page) throws Exception {
        log.info("내 피드에서 내 타임라인 리스트 조회 기능 시작");
        Pageable pageable = PageRequest.of(page, 3);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User user = null;
        if (auth != null && auth.getPrincipal() != null)
            user = (User) auth.getPrincipal();
        List<MainTimelinePhotoDtoRes> timelinelist = timeLineService.searchMyTimelineWithPaging(user, pageable);
        log.info("내 피드에서 내 타임라인 리스트 조회 기능 종료");
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
    }


    //다른 유저의 피드에서 타임라인 조회 with Paging => 테스트 해보기
    @GetMapping("/other/{uid}/{page}")
    public ResponseEntity<?> getAnotherTimelineListWithPaging(@PathVariable Long uid, @PathVariable Integer page) throws Exception {
        Pageable pageable = PageRequest.of(page, 3);
        log.info("다른 유저의 피드에서 타임라인 조회 기능 시작");
        List<MainTimelinePhotoDtoRes> timelinelist = timeLineService.searchTimelineNotPublicWithPaging(uid, pageable);
        log.info("다른 유저의 피드에서 타임라인 조회 기능 종료");
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
    }


}
