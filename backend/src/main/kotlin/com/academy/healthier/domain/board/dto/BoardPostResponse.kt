package com.academy.healthier.domain.board.dto

import com.academy.healthier.domain.board.entity.BoardPost
import java.time.LocalDateTime

data class BoardPostResponse(
    val id: Long,
    val title: String,
    val authorName: String,
    val isPinned: Boolean,
    val viewCount: Int,
    val createdAt: LocalDateTime
) {
    companion object {
        fun from(post: BoardPost): BoardPostResponse = BoardPostResponse(
            id = post.id,
            title = post.title,
            authorName = post.author.user.name,
            isPinned = post.isPinned,
            viewCount = post.viewCount,
            createdAt = post.createdAt
        )
    }
}

data class BoardPostDetailResponse(
    val id: Long,
    val title: String,
    val content: String,
    val authorName: String,
    val authorId: Long,
    val isPinned: Boolean,
    val viewCount: Int,
    val comments: List<CommentResponse>,
    val attachments: List<AttachmentResponse>,
    val createdAt: LocalDateTime
)

data class CommentResponse(
    val id: Long,
    val content: String,
    val authorName: String,
    val authorId: Long,
    val parentId: Long?,
    val createdAt: LocalDateTime
)

data class AttachmentResponse(
    val id: Long,
    val originalFilename: String,
    val fileSize: Long,
    val contentType: String
)
