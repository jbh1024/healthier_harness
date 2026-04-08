package com.academy.healthier.domain.board.repository

import com.academy.healthier.domain.board.entity.PostView
import org.springframework.data.jpa.repository.JpaRepository

interface PostViewRepository : JpaRepository<PostView, Long> {
    fun existsByPostIdAndUserId(postId: Long, userId: Long): Boolean
}
