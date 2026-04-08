package com.academy.healthier.domain.notification.dto

import com.academy.healthier.domain.notification.entity.NotificationSetting

data class NotificationSettingResponse(
    val enrollmentNotify: Boolean,
    val noticeNotify: Boolean,
    val commentNotify: Boolean
) {
    companion object {
        fun from(s: NotificationSetting): NotificationSettingResponse = NotificationSettingResponse(
            enrollmentNotify = s.enrollmentNotify,
            noticeNotify = s.noticeNotify,
            commentNotify = s.commentNotify
        )
    }
}

data class UpdateNotificationSettingRequest(
    val enrollmentNotify: Boolean?,
    val noticeNotify: Boolean?,
    val commentNotify: Boolean?
)
