package com.academy.healthier.domain.notification.dto

import com.academy.healthier.domain.notification.entity.Notification
import java.time.LocalDateTime

data class NotificationResponse(
    val id: Long,
    val type: String,
    val title: String,
    val message: String,
    val isRead: Boolean,
    val referenceType: String?,
    val referenceId: Long?,
    val createdAt: LocalDateTime
) {
    companion object {
        fun from(n: Notification): NotificationResponse = NotificationResponse(
            id = n.id,
            type = n.type.name,
            title = n.title,
            message = n.message,
            isRead = n.isRead,
            referenceType = n.referenceType,
            referenceId = n.referenceId,
            createdAt = n.createdAt
        )
    }
}
