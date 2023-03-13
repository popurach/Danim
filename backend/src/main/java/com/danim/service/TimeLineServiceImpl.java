package com.danim.service;

import com.danim.entity.TimeLine;
import com.danim.entity.User;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.danim.repository.TimeLineRepository;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class TimeLineServiceImpl implements TimeLineService {

    private final TimeLineRepository timeLineRepository;
    private final UserRepository userRepository;


    @Override
    public List<TimeLine> searchTimelineOrderBylatest() {
        return null;
    }

    @Override
    public List<TimeLine> searchMyTimeline(Long uid) {
        return null;
    }

    @Override
    public TimeLine searchOneTimeline(Long uid) {
        return null;
    }

    @Override
    public void newTimeline(Long uid) {
        //여기서 넘어온 uid는 User의 uid아이디 입니다.
        TimeLine timeline = new TimeLine();


        //이렇게 해서 User를 찾아옴
        Optional<User> now = userRepository.findById(uid);
        if (now.isPresent()) {//Optional임으로 존재한다면 새로운 타임라인 생성이 가능한다
            timeline.setUserUid(now.get());
            timeLineRepository.save(timeline);
        } else {//그렇지 않다면 찾은 User가 존재 하지 않으므로 Exception을 던져준다


        }
    }

    @Override
    public void finishTimeline(Long uid) {

    }

    @Override
    public void deleteTimeline(Long uid) {

    }

}
