package com.academy.healthier.domain.notice.dto

import com.academy.healthier.domain.notice.entity.Notice
import java.time.LocalDateTime

data class NoticeResponse(
    val id: Long,
    val title: String,
    val authorName: String,
    val isImportant: Boolean,
    val viewCount: Int,
    val createdAt: LocalDateTime
) {
    companion object {
        fun from(notice: Notice): NoticeResponse = NoticeResponse(
            id = notice.id,
            title = notice.title,
            authorName = notice.author.user.name,
            isImportant = notice.isImportant,
            viewCount = notice.viewCount,
            createdAt = notice.createdAt
        )
    }
}

data class NoticeDetailResponse(
    val id: Long,
    val title: String,
    val content: String,
    val authorName: String,
    val isImportant: Boolean,
    val viewCount: Int,
    val createdAt: LocalDateTime
)
