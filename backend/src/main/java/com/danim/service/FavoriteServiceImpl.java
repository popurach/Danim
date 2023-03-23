//package com.danim.service;
//
//import com.danim.entity.Favorite;
//import com.danim.entity.Post;
//import com.danim.entity.User;
//import com.danim.repository.FavoriteRepository;
//import com.danim.repository.PostRepository;
//import com.danim.repository.UserRepository;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//@Service
//@RequiredArgsConstructor
//public class FavoriteServiceImpl implements FavoriteService {
//    private final PostRepository postRepository;
//    private final UserRepository userRepository;
//    private final FavoriteRepository favoriteRepository;
//
//    // 해당 유저가 포스트에 좋아요 누른 여부 확인하기 (좋아요 기능)
//    public boolean isLiked (Long postId, Long userUid) throws Exception {
//        Favorite favorite = favoriteRepository.findByPostIdAndUserUid(postId, userUid);
//        // 좋아요 누른 적 없는 경우 - Favorite 생성 및 저장
//        if (favorite == null) {
//            Favorite newFavorite = new Favorite();
//            Post post = postRepository.findById(postId).get();
//            User user = userRepository.findById(userUid).get();
//            newFavorite.setPostId(post);
//            newFavorite.setUserUid(user);
//            favoriteRepository.save(newFavorite);
//            return true;
//        }
//        // 좋아요 누른 적 있는 경우 - 해당 Favorite 삭제
//        favoriteRepository.deleteById(favorite.getFavoriteId());
//        return false;
//    };
//}
