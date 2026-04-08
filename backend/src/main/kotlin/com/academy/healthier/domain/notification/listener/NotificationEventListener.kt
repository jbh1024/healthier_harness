package com.academy.healthier.domain.notification.listener

import com.academy.healthier.domain.academy.repository.AcademyRepository
import com.academy.healthier.domain.notification.entity.Notification
import com.academy.healthier.domain.notification.event.NotificationEvent
import com.academy.healthier.domain.notification.repository.NotificationRepository
import com.academy.healthier.domain.notification.repository.NotificationSettingRepository
import com.academy.healthier.domain.notification.entity.NotificationType
import com.academy.healthier.domain.user.repository.UserRepository
import org.slf4j.LoggerFactory
import org.springframework.context.event.EventListener
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
class NotificationEventListener(
    private val notificationRepository: NotificationRepository,
    private val notificationSettingRepository: NotificationSettingRepository,
    private val academyRepository: AcademyRepository,
    private val userRepository: UserRepository
) {
    private val log = LoggerFactory.getLogger(javaClass)

    @EventListener
    @Transactional
    fun handleNotificationEvent(event: NotificationEvent) {
        // 수신 설정 확인
        val setting = notificationSettingRepository.findByUserId(event.recipientUserId)
        if (setting != null && !isNotificationEnabled(setting, event.type)) {
            log.debug("알림 수신 거부: userId={}, type={}", event.recipientUserId, event.type)
            return
        }

        val academy = academyRepository.findById(event.academyId).orElse(null) ?: return
        val recipient = userRepository.findById(event.recipientUserId).orElse(null) ?: return

        // 인앱 알림 저장
        notificationRepository.save(
            Notification(
                academy = academy,
                recipient = recipient,
                type = event.type,
                title = event.title,
                message = event.message,
                referenceType = event.referenceType,
                referenceId = event.referenceId
            )
        )

        // TODO: FCM 푸시 발송 (FcmNotificationService)
        log.info("알림 저장: userId={}, type={}, title={}", event.recipientUserId, event.type, event.title)
    }

    private fun isNotificationEnabled(
        setting: com.academy.healthier.domain.notification.entity.NotificationSetting,
        type: NotificationType
    ): Boolean = when (type) {
        NotificationType.ENROLLMENT_REQUESTED,
        NotificationType.ENROLLMENT_APPROVED,
        NotificationType.ENROLLMENT_REJECTED,
        NotificationType.ENROLLMENT_CANCELLED,
        NotificationType.VACANCY_AVAILABLE -> setting.enrollmentNotify
        NotificationType.NOTICE_CREATED -> setting.noticeNotify
        NotificationType.COMMENT_CREATED -> setting.commentNotify
    }
}
