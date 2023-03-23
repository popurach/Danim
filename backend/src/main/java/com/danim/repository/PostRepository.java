package com.danim.repository;

import com.danim.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PostRepository extends JpaRepository<Post, Long> {
    // 지역명으로 post 조회(검색 기능)
    Optional<List<Post>> findByAddress1OrAddress2OrAddress3OrAddress4(String location1, String location2, String location3, String location4);
}
