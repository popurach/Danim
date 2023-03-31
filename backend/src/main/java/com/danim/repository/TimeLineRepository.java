package com.danim.repository;

import com.danim.entity.TimeLine;
import com.danim.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


//mapper와 동일한 기능을 제공한다고 생각을 하자
@Repository
public interface TimeLineRepository extends JpaRepository<TimeLine, Long> {
    @Override
    TimeLine getById(Long aLong);


    Optional<List<TimeLine>> findAllByUserUidOrderByCreateTimeDesc(User u);

    Optional<List<TimeLine>> findAllByUserUidAndTimelinePublic(User u, Boolean flag);

    Optional<List<TimeLine>> findAllByUserUid(User u);


    Page<TimeLine> findAll(Pageable pageable);

    //공개되지 않은 것들 중에, 완료가 된것만 찾아내야함
    Page<TimeLine> findAllByCompleteAndTimelinePublic(Boolean complete, Boolean public1, Pageable pageable);

    Page<TimeLine> findAllByUserUidOrderByCreateTimeDesc(User u, Pageable pageable);

    Page<TimeLine> findAllByUserUidAndTimelinePublic(User u, Boolean flag, Pageable pageable);

    List<TimeLine> findAllByUserUidAAndComplete(User u, Boolean flag);
}
