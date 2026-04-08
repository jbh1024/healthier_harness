package com.academy.healthier.domain.notice.repository

import com.academy.healthier.domain.notice.entity.NoticeView
import org.springframework.data.jpa.repository.JpaRepository

interface NoticeViewRepository : JpaRepository<NoticeView, Long> {
    fun existsByNoticeIdAndUserId(noticeId: Long, userId: Long): Boolean
}
