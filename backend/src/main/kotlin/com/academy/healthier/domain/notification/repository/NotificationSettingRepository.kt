package com.academy.healthier.domain.notification.repository

import com.academy.healthier.domain.notification.entity.NotificationSetting
import org.springframework.data.jpa.repository.JpaRepository

interface NotificationSettingRepository : JpaRepository<NotificationSetting, Long> {
    fun findByUserId(userId: Long): NotificationSetting?
}
