package com.danim.repository;

import com.danim.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MultiPartRepository extends JpaRepository<Post,Long> {
}
