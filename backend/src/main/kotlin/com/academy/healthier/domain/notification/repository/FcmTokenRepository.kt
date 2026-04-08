package com.academy.healthier.domain.notification.repository

import com.academy.healthier.domain.notification.entity.FcmToken
import org.springframework.data.jpa.repository.JpaRepository

interface FcmTokenRepository : JpaRepository<FcmToken, Long> {
    fun findByUserId(userId: Long): List<FcmToken>
    fun deleteByUserIdAndDeviceType(userId: Long, deviceType: String)
}
