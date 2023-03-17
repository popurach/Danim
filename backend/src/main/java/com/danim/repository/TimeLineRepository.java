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

    Optional<List<TimeLine>> findAllByUserUidAndTimelinePublic(User u,Boolean flag);

    Optional<List<TimeLine>> findAllByUserUid(User u);



    Page<TimeLine> findAll(Pageable pageable);

    Page<TimeLine> findAllByUserUidOrderByCreateTimeDesc(User u,Pageable pageable);

    Page<TimeLine> findAllByUserUidAndTimelinePublic(User u,Boolean flag,Pageable pageable);



}
