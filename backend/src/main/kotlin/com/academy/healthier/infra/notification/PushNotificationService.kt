package com.academy.healthier.infra.notification

interface PushNotificationService {
    fun sendToUser(userId: Long, title: String, message: String, data: Map<String, String> = emptyMap())
    fun sendToUsers(userIds: List<Long>, title: String, message: String, data: Map<String, String> = emptyMap())
}
