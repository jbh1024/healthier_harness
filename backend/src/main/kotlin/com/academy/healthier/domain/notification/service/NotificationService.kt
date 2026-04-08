package com.academy.healthier.domain.notification.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.notification.dto.NotificationResponse
import com.academy.healthier.domain.notification.dto.NotificationSettingResponse
import com.academy.healthier.domain.notification.dto.UpdateNotificationSettingRequest
import com.academy.healthier.domain.notification.entity.NotificationSetting
import com.academy.healthier.domain.notification.repository.NotificationRepository
import com.academy.healthier.domain.notification.repository.NotificationSettingRepository
import com.academy.healthier.domain.user.repository.UserRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@Service
@Transactional(readOnly = true)
class NotificationService(
    private val notificationRepository: NotificationRepository,
    private val notificationSettingRepository: NotificationSettingRepository,
    private val userRepository: UserRepository
) {

    fun getNotifications(userId: Long, pageable: Pageable): PageResponse<NotificationResponse> {
        val page = notificationRepository.findByRecipientIdOrderByCreatedAtDesc(userId, pageable)
        return PageResponse.from(page) { NotificationResponse.from(it) }
    }

    fun getUnreadCount(userId: Long): Long {
        return notificationRepository.countByRecipientIdAndIsReadFalse(userId)
    }

    @Transactional
    fun markAsRead(notificationId: Long, userId: Long) {
        val notification = notificationRepository.findById(notificationId)
            .orElseThrow { BusinessException(ErrorCode.INVALID_INPUT) }
        if (notification.recipient.id != userId) {
            throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        }
        notification.markAsRead()
    }

    @Transactional
    fun markAllAsRead(userId: Long) {
        notificationRepository.markAllAsRead(userId)
    }

    fun getSettings(userId: Long): NotificationSettingResponse {
        val setting = notificationSettingRepository.findByUserId(userId)
            ?: return NotificationSettingResponse(
                enrollmentNotify = true,
                noticeNotify = true,
                commentNotify = true
            )
        return NotificationSettingResponse.from(setting)
    }

    @Transactional
    fun updateSettings(userId: Long, request: UpdateNotificationSettingRequest): NotificationSettingResponse {
        var setting = notificationSettingRepository.findByUserId(userId)
        if (setting == null) {
            val user = userRepository.findById(userId)
                .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }
            setting = notificationSettingRepository.save(NotificationSetting(user = user))
        }

        request.enrollmentNotify?.let { setting.enrollmentNotify = it }
        request.noticeNotify?.let { setting.noticeNotify = it }
        request.commentNotify?.let { setting.commentNotify = it }
        setting.updatedAt = LocalDateTime.now()

        return NotificationSettingResponse.from(setting)
    }
}
