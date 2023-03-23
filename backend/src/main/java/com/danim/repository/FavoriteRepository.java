//package com.danim.repository;
//
//import com.danim.entity.Favorite;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;
//
//@Repository
//public interface FavoriteRepository extends JpaRepository<Favorite, Long> {
//    // 해당 포스트에 해당 유저가 좋아요 눌렀는지 여부 검색
//    Favorite findByPostIdAndUserUid(Long postId, Long userUid);
//
//    // 포스트에 눌린 좋아요 수 검색
//    Integer countByPostId(Long postId, Long userUid);
//
//    // 유저가 좋아요 누른 포스트 검색
//    Favorite findByUserUid(Long userUid);
//}
