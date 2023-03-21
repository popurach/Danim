package com.danim.repository;

import com.danim.entity.Post;
import com.danim.entity.TimeLine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostRepository extends JpaRepository<Post, Long> {
    // 지역명으로 post 조회(검색 기능)
//    List<Post> findByLocation(String location);

    Post findByTimelineId(TimeLine timeline)throws  Exception;


}
