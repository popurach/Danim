package com.danim.service;

import com.danim.entity.TimeLine;
import com.danim.entity.User;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.danim.repository.TimeLineRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class TimeLineServiceImpl implements TimeLineService {

    @Autowired
    private final TimeLineRepository timeLineRepository;
    @Autowired
    private final UserRepository userRepository;

    @Override
    public List<TimeLine> searchTimelineOrderBylatest(Long uid) throws Exception {
        Optional<User> now = userRepository.findById(uid);
        if(!now.isPresent()) {//그렇지 않다면 찾은 User가 존재 하지 않으므로 Exception을 던져준다
            //에러 던져야 할곳임
            throw new Exception("존재 하지 않는 유저");
        }
        Optional<List<TimeLine>> timeline = timeLineRepository.findAllByUserUidOrderByCreateTimeDesc(now.get());
        if (timeline.isPresent()) {//Optional임으로 존재한다면 새로운 타임라인 생성이 가능한다
            return timeline.get();
        } else {//그렇지 않다면 찾은 User가 존재 하지 않으므로 Exception을 던져준다
            //에러 던져야 할곳임
            throw new Exception("모든 최신 타임라인 얻어오기 실패");
        }
    }

    @Override
    public List<TimeLine> searchMyTimeline(Long uid) throws Exception {
        Optional<User> now = userRepository.findById(uid);
        if(!now.isPresent()) {//그렇지 않다면 찾은 User가 존재 하지 않으므로 Exception을 던져준다
            throw new Exception("존재 하지 않는 유저");
        }
        Optional<List<TimeLine>> timeline = timeLineRepository.findAllByUserUid(now.get());
        if (timeline.isPresent()) {//Optional임으로 존재한다면 새로운 타임라인 생성이 가능한다
            return timeline.get();
        } else {//그렇지 않다면 찾은 User가 존재 하지 않으므로 Exception을 던져준다
            //에러 던져야 할곳임
            throw new Exception("타임라인 얻어오기 실패");
        }
    }

    @Override
    public TimeLine searchOneTimeline(Long uid) throws Exception {

        TimeLine timeline = new TimeLine();
        //이렇게 해서 User를 찾아옴
        Optional<User> now = userRepository.findById(uid);
        if (now.isPresent()) {//Optional임으로 존재한다면 새로운 타임라인 생성이 가능한다
            timeline.setUserUid(now.get());
            timeLineRepository.save(timeline);
            return timeline;
        } else {//그렇지 않다면 찾은 User가 존재 하지 않으므로 Exception을 던져준다
            //에러 던져야 할곳임
            throw new Exception("타임라인 생성시 애러임");
        }
    }

    @Override
    public void makenewTimeline(Long uid) throws Exception {
        //여기서 넘어온 uid는 User의 uid아이디 입니다.
        TimeLine timeline = new TimeLine();
        //이렇게 해서 User를 찾아옴
        Optional<User> now = userRepository.findById(uid);
        if (now.isPresent()) {//Optional임으로 존재한다면 새로운 타임라인 생성이 가능한다
            timeline.setUserUid(now.get());
            timeLineRepository.save(timeline);
        } else {//그렇지 않다면 찾은 User가 존재 하지 않으므로 Exception을 던져준다
            //에러 던져야 할곳임
            throw new Exception("타임라인 생성시 애러임");
        }
    }

    @Override
    public void finishTimeline(Long uid) throws Exception {

        Optional<TimeLine> now = timeLineRepository.findById(uid);
        if (now.isPresent()) {//Optional임으로 존재한다면 새로운 타임라인 생성이 가능한다
            TimeLine timeline = now.get();
            timeline.setComplete(Boolean.TRUE);
            timeline.setFinishTime(LocalDateTime.now());
            timeLineRepository.save(timeline);
        } else {//그렇지 않다면 찾은 timeline이 존재 하지 않으므로 Exception을 던져준다
            //에러 던져야 할곳임
            throw new Exception("타임라인 생성시 애러임");
        }

    }

    @Override
    public void deleteTimeline(Long uid) throws Exception {

        Optional<TimeLine> now = timeLineRepository.findById(uid);
        if (now.isPresent()) {//Optional임으로 존재한다면 새로운 타임라인 생성이 가능한다
            TimeLine timeline = now.get();
            timeLineRepository.delete(timeline);
        } else {//그렇지 않다면 찾은 timeline이 존재 하지 않으므로 Exception을 던져준다
            //에러 던져야 할곳임
            throw new Exception("타임라인 삭제시 애러임");
        }
    }

    @Override
    public void changePublic(Long uid) throws Exception {
        Optional<TimeLine> now = timeLineRepository.findById(uid);
        if (now.isPresent()) {//Optional임으로 존재한다면 새로운 타임라인 생성이 가능한다
            TimeLine timeline = now.get();
            Boolean temp = timeline.getTimelinePublic();
            if (temp) {
                timeline.setTimelinePublic(false);

            } else {
                timeline.setTimelinePublic(true);
            }
            timeLineRepository.save(timeline);
        } else {//그렇지 않다면 찾은 timeline이 존재 하지 않으므로 Exception을 던져준다
            //에러 던져야 할곳임
            throw new Exception("존재 하지 않는 타임라인 입니다");
        }
    }

}
