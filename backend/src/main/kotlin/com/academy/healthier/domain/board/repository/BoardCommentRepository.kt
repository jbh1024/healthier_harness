package com.academy.healthier.domain.board.repository

import com.academy.healthier.domain.board.entity.BoardComment
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface BoardCommentRepository : JpaRepository<BoardComment, Long> {

    @Query("""
        SELECT c FROM BoardComment c
        JOIN FETCH c.author a
        JOIN FETCH a.user
        WHERE c.post.id = :postId
        ORDER BY c.createdAt ASC
    """)
    fun findByPostIdWithAuthor(postId: Long): List<BoardComment>
}
