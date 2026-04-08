package com.academy.healthier.infra.notification

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class NoOpPushNotificationService : PushNotificationService {

    private val log = LoggerFactory.getLogger(javaClass)

    override fun sendToUser(userId: Long, title: String, message: String, data: Map<String, String>) {
        log.info("[NoOp Push] userId={}, title={}, message={}", userId, title, message)
    }

    override fun sendToUsers(userIds: List<Long>, title: String, message: String, data: Map<String, String>) {
        log.info("[NoOp Push] userIds={}, title={}, message={}", userIds, title, message)
    }
}
