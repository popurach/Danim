package com.danim.controller;

import com.danim.dto.MainTimelinePhotoDto;
import com.danim.dto.TimelinePostOuter;
import com.danim.entity.TimeLine;
import com.danim.service.TimeLineService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RequiredArgsConstructor
@RequestMapping("/api/auth/timeline")
@RestController
public class TimelineController {

    private final TimeLineService service;

    //메인피드 최신순 타임라인 조회
    @GetMapping("/main")
    public ResponseEntity<?> getTimelineLatest() throws Exception {


//        Account auth = (Account) authentication.getPrincipal();
//        Long tt = auth.getUid();
//        Member savedUser = memberservice.signup(member.getName(), member.getNickname(), tt);
        List<TimeLine> timelinelist = service.searchTimelineOrderBylatest();
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);

    }

    //내 피드에서 내 타임라인 리스트 조회
    @GetMapping("/mine/{uid}")
    public ResponseEntity<?> getMyTimelineList(@PathVariable Long uid) throws Exception {

        List<TimeLine> timelinelist = service.searchMyTimeline(uid);
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
    }

    //다른 유저의 피드에서 타임라인 조회
    @GetMapping("/user/{uid}")
    public ResponseEntity<?> getAnotherTimelineList(@PathVariable Long uid) throws Exception {

        List<TimeLine> timelinelist = service.searchTimelineNotPublic(uid);
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
    }


    //타임라인 한개 조회 => 이제 이걸 해야함 , 넘겨줄때 여행한 국가 리스트 순서대로 해서 만들어 넘겨주면 될듯
    @GetMapping("/{uid}")
    public ResponseEntity<?> seleteOneTimeLine(@PathVariable Long uid) throws Exception {
        TimelinePostOuter timeline = service.searchOneTimeline(uid);
        return new ResponseEntity<>(timeline, HttpStatus.OK);
    }

    //여행시작 , 여기에는 사용자 를 구분할수 있는 requestbody가 필요하다
    @PostMapping("")
    public ResponseEntity<?> makeTimeLine() throws Exception {
        //유저 한명을 받아 와서 해당 유저로 타임라인을 생성하고자 한다
        service.makenewTimeline(15L);
        return new ResponseEntity<>(HttpStatus.OK);
    }


    //여행끝
    @PutMapping("/{uid}")
    public ResponseEntity<?> finishTimeLine(@PathVariable Long uid) throws Exception {
        service.finishTimeline(uid);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    //타임라인 공개 <->비공개 변경
    @PutMapping("/switch/{uid}")
    public ResponseEntity<?> changeTimeLinePublic(@PathVariable Long uid) throws Exception {

        service.changePublic(uid);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    //타임라인삭제
    @DeleteMapping("/{uid}")
    public ResponseEntity<?> deleteTimeLine(@PathVariable Long uid) throws Exception {
        service.deleteTimeline(uid);
        return new ResponseEntity<>(HttpStatus.OK);
    }


    /*paging  하는 메서드들*/


    //메인피드 최신순 타임라인 조회 with paging +  
    //어떤 유저로 받을지는 파라미터에 추가가 되어야 함
    //sort="id", direction = Sort.Direction.DESC
    @GetMapping("/main/test")//테스트 해보기
    public ResponseEntity<?> getTimelineLatestWithPaging(@PageableDefault(sort = "createTime", direction = Sort.Direction.DESC, size = 3) Pageable pageable) throws Exception {

        List<MainTimelinePhotoDto> timelinelist = service.searchTimelineOrderBylatestPaging(pageable);
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
    }

    //내 피드에서 내 타임라인 리스트 조회 with paging =>테스트 해보기
    @GetMapping("/mine/test")
    public ResponseEntity<?> getMyTimelineListWithPaging(@PageableDefault(size = 3) Pageable pageable) throws Exception {
        List<MainTimelinePhotoDto> timelinelist = service.searchMyTimelineWithPaging(1L, pageable);
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
    }

    //다른 유저의 피드에서 타임라인 조회 with Paging => 테스트 해보기
    @GetMapping("/other/text/{uid}")
    public ResponseEntity<?> getAnotherTimelineListWithPaging(@PathVariable Long uid, @PageableDefault(size = 3) Pageable pageable) throws Exception {
        List<MainTimelinePhotoDto> timelinelist = service.searchTimelineNotPublicWithPaging(uid, pageable);
        return new ResponseEntity<>(timelinelist, HttpStatus.OK);
    }

}
