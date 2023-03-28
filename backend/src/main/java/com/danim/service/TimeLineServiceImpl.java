package com.danim.service;

import com.danim.dto.MainTimelinePhotoDtoRes;
import com.danim.dto.MyPostDtoRes;
import com.danim.dto.TimelinePostInner;
import com.danim.dto.TimelinePostOuter;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.entity.TimeLine;
import com.danim.entity.User;
import com.danim.exception.BaseException;
import com.danim.exception.ErrorMessage;
import com.danim.repository.PhotoRepository;
import com.danim.repository.PostRepository;
import com.danim.repository.TimeLineRepository;
import com.danim.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class TimeLineServiceImpl implements TimeLineService {

    private final TimeLineRepository timeLineRepository;
    private final UserRepository userRepository;
    private final PostRepository postRepository;
    private final PhotoRepository photoRepository;


    @Override
    //모든 최신 타임라인 얻어옴 , 페이징 x
    public List<TimeLine> searchTimelineOrderBylatest() throws BaseException {
        //User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        //List<TimeLine> timeline = timeLineRepository.findAllByUserUidOrderByCreateTimeDesc(now).orElseThrow(() -> new Exception("모든 최신 타임라인 얻어오기 실패"));
        List<TimeLine> timeline = timeLineRepository.findAll(Sort.by(Sort.Direction.DESC, "createTime"));
        return timeline;
    }

    @Override
    //나의 타임라인 얻어옴 , 페이징 x
    public List<TimeLine> searchMyTimeline(Long uid, User now) throws BaseException {
        //User now = userRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
        List<TimeLine> timeline = timeLineRepository.findAllByUserUid(now).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_TIMELINE));
        return timeline;
    }

    //찾고자 하는 상대 유저의 public이지 않은 타임라인 탐색 하는 메서드
    @Override
    public List<TimeLine> searchTimelineNotPublic(Long uid) throws BaseException {
        User now = userRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
        List<TimeLine> timeline = timeLineRepository.findAllByUserUidAndTimelinePublic(now, true).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_TIMELINE));
        return timeline;
    }

    @Override
    public TimelinePostOuter searchOneTimeline(Long uid) throws BaseException {

        //해당 되는 타임라인을 얻어 왔고
        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_TIMELINE));

        //이제 그 다음으로 해당 되는 타임라인을 포스트를 얻어 올거임
        List<Post> post = postRepository.findAllByTimelineIdOrderByCreateTimeAsc(now);
        //이제 찾아 왔으므로 넘겨 줘야함


        //딕셔너리 형태로 해서 있으면 넣고 없으면 제외를 하도록 하자
        //타임 라인 하나를 넘겨 주는데 어떻게 넘겨 줄지 문제가 되네
        TimelinePostOuter timelineouter = new TimelinePostOuter();

        List<MyPostDtoRes> postlist = new ArrayList<>();
        TimelinePostInner temptimeline = new TimelinePostInner();
        Map<String, String> temp = new HashMap<String, String>();//그전에 국가 이름이 존재 하지 않는지 파악 하기 위해
        List<String> tempnow = new ArrayList<>();//여행한 국가의 모든 국가 리스트를 순서대로 겹치지 않게 파악하기 위해 해주는 작업

        for (Post p : post) {
            String NationName = p.getNationId().getName();

            if (!temp.containsKey(NationName)) {//해당 부분은 여행 국가가 새로 나타난 형태를 의미를 함

                if (postlist.size() > 0) {
                    temptimeline.setPostlist(postlist);
                    //그전에 했던 국가 , 국기, List<post>를 넣어주는 작업 진행할 부분
                    timelineouter.getTimeline().add(temptimeline);
                }
                //이제 새로운 타임라인 생성을 하고 국가, 국기, post를 넣어주는 작업이다
                postlist = new ArrayList<>();
                temptimeline = new TimelinePostInner();
                temptimeline.setFlag(p.getPhotoList().get(0).getPhotoUrl());
                temptimeline.setNation(NationName);
                tempnow.add(NationName);
                temp.put(NationName, "1");
                postlist.add(MyPostDtoRes.builder(p).build());

            } else {
                //나온 국가가 그전에 있던거에 이어져서 가는 형태로 파악을 하면됨
                postlist.add(MyPostDtoRes.builder(p).build());
            }
        }
        //가장 마지막에 남은 것들 처리해 주는 과정
        temptimeline.setPostlist(postlist);
        timelineouter.getTimeline().add(temptimeline);

        timelineouter.setNationList(tempnow);//중복 되지 않는 타임라인의 모든 국가 리스트 를 설정해 주는 작업이다.
        return timelineouter;
    }

    @Override
    public void makenewTimeline(User now) throws BaseException {
        //여기서 넘어온 uid는 User의 uid아이디 입니다.
        TimeLine timeline = new TimeLine();
        //이렇게 해서 User를 찾아옴
        //User now = userRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));

        //새로운 타임라인 생성이 가능한다
        timeline.setUserUid(now);
        timeLineRepository.save(timeline);
    }


    @Override
    public void finishTimeline(Long uid) throws BaseException {

        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_TIMELINE));
        //타임라인 완료 변경 작업 진행

        now.setComplete(Boolean.TRUE);
        now.setFinishTime(LocalDateTime.now());
        timeLineRepository.save(now);
    }


    @Override
    public void deleteTimeline(Long uid) throws BaseException {

        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
        timeLineRepository.delete(now);
    }

    @Override
    public void changePublic(Long uid) throws BaseException {
        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_TIMELINE));
        Boolean temp = now.getTimelinePublic();

        //완료->비완료 , 비완료->완료 로 변경하는 작업
        if (temp) {
            now.setTimelinePublic(false);

        } else {
            now.setTimelinePublic(true);
        }
        timeLineRepository.save(now);

    }

    //타임라인 중에서 완료가 된 여행과 공개가 된 여행을 페이징 처리르 하여 보여준다 => 메인 피드 화면에서 타임라인과 썸네일 같이 넘어감
    @Override
    public List<MainTimelinePhotoDtoRes> searchTimelineOrderBylatestPaging(Pageable pageable) throws BaseException {

        Page<TimeLine> timeline = timeLineRepository.findAllByCompleteAndTimelinePublic(true, true, pageable);
        if (timeline.getContent().size() == 0) {
            throw new BaseException(ErrorMessage.NOT_EXIST_TIMELINE_PAGING);
        }

        //이제 얻어낸 타임라인 리스트에 해당 되는 포스트 정보를 불러오도록 한다.
        List<MainTimelinePhotoDtoRes> list = new ArrayList<>();//넘겨줄 timeline dto생성
        //이때 타임라인에서 post가 있는 친구는 보여주고 없으면 보여 주지 않아야 할듯 하다

        for (TimeLine time : timeline) {
            Post startpost = postRepository.findTopByTimelineIdOrderByCreateTimeAsc(time);
            Post lastpost = postRepository.findTopByTimelineIdOrderByCreateTimeDesc(time);
            //지금 상태로는 타임라인에 등록이 된 post가 아닌지 확인을 해서 넘겨 주도록 해야한다
            if (startpost == null || lastpost == null)
                continue;
            //현재는 우선 임시로 작업을 하여 넣어 줄것으로 생각을 하고 있다.
            Photo photo = photoRepository.findById(startpost.getPhotoList().get(0).getPhotoId()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_PHOTO));
            //Long uid = time.getTimelineId();
            User user = userRepository.findById(time.getTimelineId()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
            MainTimelinePhotoDtoRes temp = MainTimelinePhotoDtoRes.builder(time, startpost, lastpost, photo, user).build();
            list.add(temp);
        }

        return list;
    }

    //나의 타임라인 검색시 페이징 처리해서 검색을 해온다 => 나의 타임라인 조회를 할시에 비어 있는 타임라인으로 넘겨줄거임
    @Override
    public List<MainTimelinePhotoDtoRes> searchMyTimelineWithPaging(User now, Pageable pageable) throws BaseException {
        // User now = userRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
        Photo photo = null;
        User user = null;
        Post post = null;
        MainTimelinePhotoDtoRes temp = null;

        Page<TimeLine> timeline = timeLineRepository.findAllByUserUidOrderByCreateTimeDesc(now, pageable);
        if (timeline.getContent().size() == 0) {
            throw new BaseException(ErrorMessage.NOT_EXIST_TIMELINE_PAGING);
        }
        //이제 얻어낸 타임라인 리스트에 해당 되는 포스트 정보를 불러오도록 한다.
        List<MainTimelinePhotoDtoRes> list = new ArrayList<>();//넘겨줄 timeline dto생성
        //타임라인을 얻어옴, =>
        for (TimeLine time : timeline) {
            Post startpost = postRepository.findTopByTimelineIdOrderByCreateTimeAsc(time);
            Post lastpost = postRepository.findTopByTimelineIdOrderByCreateTimeDesc(time);
            //지금 상태로는 타임라인에 등록이 된 post가 아닌지 확인을 해서 넘겨 주도록 해야한다
            if (startpost == null || lastpost == null) {//해당 되는 부분에는
                photo = new Photo();
                photo.setPhotoUrl("");
                if (startpost == null) {
                    startpost = new Post();
                    startpost.setAddress2("");
                }
                if (lastpost == null) {
                    lastpost = new Post();
                    lastpost.setAddress2("");
                }
                user = userRepository.findById(time.getUserUid().getUserUid()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
                temp = MainTimelinePhotoDtoRes.builder(time, startpost, lastpost, photo, user).build();
                list.add(temp);
            } else {
                //현재는 우선 임시로 작업을 하여 넣어 줄것으로 생각을 하고 있다.
                photo = photoRepository.findById(startpost.getPhotoList().get(0).getPhotoId()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_PHOTO));
                user = userRepository.findById(time.getUserUid().getUserUid()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
                temp = MainTimelinePhotoDtoRes.builder(time, startpost, lastpost, photo, user).build();
                list.add(temp);
            }
        }
        return list;
    }

    //상대 타임라인 조회시 with Paging
    @Override
    public List<MainTimelinePhotoDtoRes> searchTimelineNotPublicWithPaging(Long uid, Pageable pageable) throws BaseException {
        User user = userRepository.findById(uid).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
        Page<TimeLine> timeline = timeLineRepository.findAllByUserUidAndTimelinePublic(user, true, pageable);
        if (timeline.getContent().size() == 0) {
            throw new BaseException(ErrorMessage.NOT_EXIST_TIMELINE);
        }
        Photo photo = null;
        Post post = null;
        MainTimelinePhotoDtoRes temp = null;
        if (timeline.getContent().size() == 0) {
            throw new BaseException(ErrorMessage.NOT_EXIST_TIMELINE_PAGING);
        }
        //이제 얻어낸 타임라인 리스트에 해당 되는 포스트 정보를 불러오도록 한다.
        List<MainTimelinePhotoDtoRes> list = new ArrayList<>();//넘겨줄 timeline dto생성
        //타임라인을 얻어옴, =>
        for (TimeLine time : timeline) {
            Post startpost = postRepository.findTopByTimelineIdOrderByCreateTimeAsc(time);
            Post lastpost = postRepository.findTopByTimelineIdOrderByCreateTimeDesc(time);
            //지금 상태로는 타임라인에 등록이 된 post가 아닌지 확인을 해서 넘겨 주도록 해야한다
            if (startpost == null || lastpost == null) {//해당 되는 부분에는
                photo = new Photo();
                photo.setPhotoUrl("");
                if (startpost == null) {
                    startpost = new Post();
                    startpost.setAddress2("");
                }
                if (lastpost == null) {
                    lastpost = new Post();
                    lastpost.setAddress2("");
                }

                temp = MainTimelinePhotoDtoRes.builder(time, startpost, lastpost, photo, user).build();
                list.add(temp);
            } else {
                //현재는 우선 임시로 작업을 하여 넣어 줄것으로 생각을 하고 있다.
                photo = photoRepository.findById(startpost.getPhotoList().get(0).getPhotoId()).orElseThrow(() -> new BaseException(ErrorMessage.NOT_EXIST_USER));
                temp = MainTimelinePhotoDtoRes.builder(time, startpost, lastpost, photo, user).build();
                list.add(temp);
            }
        }
        return list;
    }


}
