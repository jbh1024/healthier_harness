package com.academy.healthier.domain.notice.repository

import com.academy.healthier.domain.notice.entity.Notice
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query

interface NoticeRepository : JpaRepository<Notice, Long> {

    @Query("""
        SELECT n FROM Notice n
        JOIN FETCH n.author a
        JOIN FETCH a.user
        WHERE n.academy.id = :academyId
        ORDER BY n.isImportant DESC, n.createdAt DESC
    """,
        countQuery = "SELECT COUNT(n) FROM Notice n WHERE n.academy.id = :academyId")
    fun findByAcademyId(academyId: Long, pageable: Pageable): Page<Notice>

    @Query("SELECT n FROM Notice n JOIN FETCH n.author a JOIN FETCH a.user WHERE n.id = :noticeId")
    fun findByIdWithAuthor(noticeId: Long): Notice?

    @Modifying
    @Query("UPDATE Notice n SET n.viewCount = n.viewCount + 1 WHERE n.id = :noticeId")
    fun incrementViewCount(noticeId: Long)
}
