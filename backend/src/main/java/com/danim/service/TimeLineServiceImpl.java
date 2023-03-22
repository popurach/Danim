package com.danim.service;

import com.danim.dto.MainTimelinePhotoDto;
import com.danim.dto.TimelinePostInner;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.entity.TimeLine;
import com.danim.entity.User;
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

import javax.persistence.criteria.CriteriaBuilder;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class TimeLineServiceImpl implements TimeLineService {

    private final TimeLineRepository timeLineRepository;
    private final UserRepository userRepository;

    private final PostRepository postRepository;

    private final PhotoRepository photoRepository;


    @Override
    //모든 최신 타임라인 얻어옴 , 페이징 x
    public List<TimeLine> searchTimelineOrderBylatest() throws Exception {
        //User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        //List<TimeLine> timeline = timeLineRepository.findAllByUserUidOrderByCreateTimeDesc(now).orElseThrow(() -> new Exception("모든 최신 타임라인 얻어오기 실패"));
        List<TimeLine> timeline = timeLineRepository.findAll(Sort.by(Sort.Direction.DESC, "createTime"));
        return timeline;

    }

    @Override
    //나의 타임라인 얻어옴 , 페이징 x
    public List<TimeLine> searchMyTimeline(Long uid) throws Exception {
        User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        List<TimeLine> timeline = timeLineRepository.findAllByUserUid(now).orElseThrow(() -> new Exception("타임라인 얻어오기 실패"));
        return timeline;
    }

    //찾고자 하는 상대 유저의 public이지 않은 타임라인 탐색 하는 메서드
    @Override
    public List<TimeLine> searchTimelineNotPublic(Long uid) throws Exception {
        User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        List<TimeLine> timeline = timeLineRepository.findAllByUserUidAndTimelinePublic(now, true).orElseThrow(() -> new Exception("타임라인 얻어오기 실패"));
        return timeline;
    }

    @Override
    public TimeLine searchOneTimeline(Long uid) throws Exception {


        //해당 되는 타임라인을 얻어 왔고
        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 타임라인 입니다."));

        //이제 그 다음으로 해당 되는 타임라인으 포스트를 얻어 올거임
        List<Post> post = postRepository.findAllByTimelineIdOrderByCreateTimeAsc(now);
        //이제 찾아 왔으므로 넘겨 줘야함

        List<String> nationlist = new ArrayList<>();
        List<Integer> nationIndex = new ArrayList<>();

        //딕셔너리 형태로 해서 있으면 넣고 없으면 제외를 하도록 하자
        //타임 라인 하나를 넘겨 주는데 어떻게 넘겨 줄지 문제가 되네

        List<TimelinePostInner> timelineinnter = new ArrayList<>();
        Map<String,String> temp=new HashMap<String,String>();

        List<String> tempnow=new ArrayList<>();


        for (Post p:post) {

            //if(p.get)



        }








        return now;
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

        now.setComplete(Boolean.TRUE);
        now.setFinishTime(LocalDateTime.now());
        timeLineRepository.save(now);

    }


    @Override
    public void deleteTimeline(Long uid) throws Exception {

        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));

        timeLineRepository.delete(now);

    }

    @Override
    public void changePublic(Long uid) throws Exception {
        TimeLine now = timeLineRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 타임라인 입니다"));
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
    public List<MainTimelinePhotoDto> searchTimelineOrderBylatestPaging(Pageable pageable) throws Exception {

        Page<TimeLine> timeline = timeLineRepository.findAllByCompleteAndTimelinePublic(true, true, pageable);
        if (timeline.getContent().size() == 0) {
            throw new Exception("존재하지 않는 타임라인 페이징의 페이지 입니다");
        }

        //이제 얻어낸 타임라인 리스트에 해당 되는 포스트 정보를 불러오도록 한다.
        List<MainTimelinePhotoDto> list = new ArrayList<>();//넘겨줄 timeline dto생성
        //이때 타임라인에서 post가 있는 친구는 보여주고 없으면 보여 주지 않아야 할듯 하다

        for (TimeLine time : timeline) {
            Post post = postRepository.findTopByTimelineIdOrderByCreateTimeAsc(time);
            //지금 상태로는 타임라인에 등록이 된 post가 아닌지 확인을 해서 넘겨 주도록 해야한다
            if (post == null)
                continue;
            //현재는 우선 임시로 작업을 하여 넣어 줄것으로 생각을 하고 있다.
            Photo photo = photoRepository.findById(post.getPhotoList().get(0).getPhotoId()).orElseThrow(() -> new Exception("존재하지 않는 사진 입니다"));
            User user = userRepository.findById(1L).orElseThrow(() -> new Exception("존재 하지 않는 유저입니다"));
            MainTimelinePhotoDto temp = MainTimelinePhotoDto.builder(time, photo, user).build();
            list.add(temp);
        }

        return list;
    }

    //나의 타임라인 검색시 페이징 처리해서 검색을 해온다 => 나의 타임라인 조회를 할시에 비어 있는 타임라인으로 넘겨줄거임
    @Override
    public List<MainTimelinePhotoDto> searchMyTimelineWithPaging(Long uid, Pageable pageable) throws Exception {
        User now = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        Photo photo = null;
        User user = null;
        Post post = null;
        MainTimelinePhotoDto temp = null;

        Page<TimeLine> timeline = timeLineRepository.findAllByUserUidOrderByCreateTimeDesc(now, pageable);
        if (timeline.getContent().size() == 0) {
            throw new Exception("존재하지 않는 타임라인 페이징의 페이지 입니다");
        }
        //이제 얻어낸 타임라인 리스트에 해당 되는 포스트 정보를 불러오도록 한다.
        List<MainTimelinePhotoDto> list = new ArrayList<>();//넘겨줄 timeline dto생성
        //타임라인을 얻어옴, =>
        for (TimeLine time : timeline) {
            post = postRepository.findTopByTimelineIdOrderByCreateTimeAsc(time);
            //지금 상태로는 타임라인에 등록이 된 post가 아닌지 확인을 해서 넘겨 주도록 해야한다
            if (post == null) {//해당 되는 부분에는
                photo = new Photo();
                photo.setPhotoUrl("");
                user = userRepository.findById(1L).orElseThrow(() -> new Exception("존재 하지 않는 유저입니다"));
                temp = MainTimelinePhotoDto.builder(time, photo, user).build();
                list.add(temp);
            } else {
                //현재는 우선 임시로 작업을 하여 넣어 줄것으로 생각을 하고 있다.
                photo = photoRepository.findById(post.getPhotoList().get(0).getPhotoId()).orElseThrow(() -> new Exception("존재하지 않는 사진 입니다"));
                user = userRepository.findById(1L).orElseThrow(() -> new Exception("존재 하지 않는 유저입니다"));
                temp = MainTimelinePhotoDto.builder(time, photo, user).build();
                list.add(temp);
            }
        }
        return list;
    }

    //상대 타임라인 조회시 with Paging
    @Override
    public List<MainTimelinePhotoDto> searchTimelineNotPublicWithPaging(Long uid, Pageable pageable) throws Exception {
        User user = userRepository.findById(uid).orElseThrow(() -> new Exception("존재하지 않는 유저"));
        Page<TimeLine> timeline = timeLineRepository.findAllByUserUidAndTimelinePublic(user, true, pageable);
        if (timeline.getContent().size() == 0) {
            throw new Exception("존재하지 않는 타임라인 페이징의 페이지 입니다");
        }
        Photo photo = null;
        Post post = null;
        MainTimelinePhotoDto temp = null;
        if (timeline.getContent().size() == 0) {
            throw new Exception("존재하지 않는 타임라인 페이징의 페이지 입니다");
        }
        //이제 얻어낸 타임라인 리스트에 해당 되는 포스트 정보를 불러오도록 한다.
        List<MainTimelinePhotoDto> list = new ArrayList<>();//넘겨줄 timeline dto생성
        //타임라인을 얻어옴, =>
        for (TimeLine time : timeline) {
            post = postRepository.findTopByTimelineIdOrderByCreateTimeAsc(time);
            //지금 상태로는 타임라인에 등록이 된 post가 아닌지 확인을 해서 넘겨 주도록 해야한다
            if (post == null) {//해당 되는 부분에는
                photo = new Photo();
                photo.setPhotoUrl("");

                temp = MainTimelinePhotoDto.builder(time, photo, user).build();
                list.add(temp);
            } else {
                //현재는 우선 임시로 작업을 하여 넣어 줄것으로 생각을 하고 있다.
                photo = photoRepository.findById(post.getPhotoList().get(0).getPhotoId()).orElseThrow(() -> new Exception("존재하지 않는 사진 입니다"));
                temp = MainTimelinePhotoDto.builder(time, photo, user).build();
                list.add(temp);
            }
        }
        return list;
    }


}
