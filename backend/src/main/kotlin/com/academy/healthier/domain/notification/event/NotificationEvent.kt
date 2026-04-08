package com.academy.healthier.domain.notification.event

import com.academy.healthier.domain.notification.entity.NotificationType

data class NotificationEvent(
    val academyId: Long,
    val recipientUserId: Long,
    val type: NotificationType,
    val title: String,
    val message: String,
    val referenceType: String? = null,
    val referenceId: Long? = null
)
