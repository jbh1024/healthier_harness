package com.academy.healthier.domain.board.repository

import com.academy.healthier.domain.board.entity.BoardPost
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query

interface BoardPostRepository : JpaRepository<BoardPost, Long> {

    @Query("""
        SELECT p FROM BoardPost p
        JOIN FETCH p.author a
        JOIN FETCH a.user
        WHERE p.academy.id = :academyId
        ORDER BY p.isPinned DESC, p.createdAt DESC
    """,
        countQuery = "SELECT COUNT(p) FROM BoardPost p WHERE p.academy.id = :academyId")
    fun findByAcademyId(academyId: Long, pageable: Pageable): Page<BoardPost>

    @Query("SELECT p FROM BoardPost p JOIN FETCH p.author a JOIN FETCH a.user WHERE p.id = :postId")
    fun findByIdWithAuthor(postId: Long): BoardPost?

    @Modifying
    @Query("UPDATE BoardPost p SET p.viewCount = p.viewCount + 1 WHERE p.id = :postId")
    fun incrementViewCount(postId: Long)
}
