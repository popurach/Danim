package com.danim.repository;

import com.danim.entity.TimeLine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


//mapper와 동일한 기능을 제공한다고 생각을 하자
@Repository
public interface TimeLineRepository extends JpaRepository<TimeLine, Long> {

    @Override
    TimeLine getById(Long aLong);





}
