package com.academy.healthier.domain.notification.repository

import com.academy.healthier.domain.notification.entity.Notification
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query

interface NotificationRepository : JpaRepository<Notification, Long> {

    fun findByRecipientIdOrderByCreatedAtDesc(recipientId: Long, pageable: Pageable): Page<Notification>

    fun countByRecipientIdAndIsReadFalse(recipientId: Long): Long

    @Modifying
    @Query("UPDATE Notification n SET n.isRead = true WHERE n.recipient.id = :recipientId AND n.isRead = false")
    fun markAllAsRead(recipientId: Long)
}
