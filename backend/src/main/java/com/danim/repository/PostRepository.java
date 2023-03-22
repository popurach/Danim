package com.danim.repository;

import com.danim.entity.Post;
import com.danim.entity.TimeLine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostRepository extends JpaRepository<Post, Long> {
    // 지역명으로 post 조회(검색 기능)

    List<Post> findByAddress1OrAddress2OrAddress3OrAddress4(String location1, String location2, String location3, String location4);

//    List<Post> findByLocation(String location);

    //Optional<List<TimeLine>> findAllByUserUidOrderByCreateTimeDesc(User u);

    List<Post> findByTimelineIdOrderByCreateTimeAsc(TimeLine timeline) throws Exception;

    Post findTopByTimelineIdOrderByCreateTimeAsc(TimeLine timeline) throws Exception;

    List<Post> findAllByTimelineIdOrderByCreateTimeAsc(TimeLine timeLine) throws Exception;

    Post findTopByTimelineIdOrderByCreateTimeDesc(TimeLine timeline) throws Exception;


}
