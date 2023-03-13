package com.danim.service;

import com.danim.entity.TimeLine;
import com.danim.entity.User;
import com.danim.repository.TimeLineRepository;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class TimeLineServiceImpl implements TimeLineService {

    private final TimeLineRepository timeLineRepository;
    private final UserRepository userRepository;

    @Override
    public List<TimeLine> searchTimelineOrderBylatest(Long uid) throws Exception {
        User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        List<TimeLine> timeline = timeLineRepository.findAllByUserUidOrderByCreateTimeDesc(now).orElseThrow(() -> new Exception("모든 최신 타임라인 얻어오기 실패"));
        return timeline;

    }

    @Override
    public List<TimeLine> searchMyTimeline(Long uid) throws Exception {
        User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        List<TimeLine> timeline = timeLineRepository.findAllByUserUid(now).orElseThrow(() -> new Exception("타임라인 얻어오기 실패"));
        return timeline;
    }

    @Override
    public List<TimeLine> searchTimelineNotPublic(Long uid) throws Exception {
        User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        List<TimeLine> timeline = timeLineRepository.findAllByUserUidAndTimelinePublic(now, true).orElseThrow(() -> new Exception("타임라인 얻어오기 실패"));
        return timeline;
    }

    @Override
    public TimeLine searchOneTimeline(Long uid) throws Exception {

        TimeLine timeline = new TimeLine();
        //이렇게 해서 User를 찾아옴
        User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));

        //timeline 변경 사항 반영하는 과정
        timeline.setUserUid(now);
        timeLineRepository.save(timeline);
        return timeline;

    }

    @Override
    public void makenewTimeline(Long uid) throws Exception {
        //여기서 넘어온 uid는 User의 uid아이디 입니다.
        TimeLine timeline = new TimeLine();
        //이렇게 해서 User를 찾아옴
        User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));

        //새로운 타임라인 생성이 가능한다
        timeline.setUserUid(now);
        timeLineRepository.save(timeline);

    }

    @Override
    public void finishTimeline(Long uid) throws Exception {

        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 타임라인 입니다."));

        //타임라인 완료 변경 작업 진행
        TimeLine timeline = now;
        timeline.setComplete(Boolean.TRUE);
        timeline.setFinishTime(LocalDateTime.now());
        timeLineRepository.save(timeline);

    }

    @Override
    public void deleteTimeline(Long uid) throws Exception {

        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));


        TimeLine timeline = now;
        timeLineRepository.delete(timeline);

    }

    @Override
    public void changePublic(Long uid) throws Exception {
        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 타임라인 입니다"));

        TimeLine timeline = now;
        Boolean temp = timeline.getTimelinePublic();

        //완료->비완료 , 비완료->완료 로 변경하는 작업
        if (temp) {
            timeline.setTimelinePublic(false);

        } else {
            timeline.setTimelinePublic(true);
        }
        timeLineRepository.save(timeline);
    }

}
