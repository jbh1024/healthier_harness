package com.academy.healthier.domain.board.repository

import com.academy.healthier.domain.board.entity.BoardAttachment
import org.springframework.data.jpa.repository.JpaRepository

interface BoardAttachmentRepository : JpaRepository<BoardAttachment, Long> {
    fun findByPostId(postId: Long): List<BoardAttachment>
}
