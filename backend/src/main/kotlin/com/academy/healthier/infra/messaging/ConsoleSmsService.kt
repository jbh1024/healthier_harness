package com.academy.healthier.infra.messaging

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class ConsoleSmsService : SmsService {
    private val log = LoggerFactory.getLogger(javaClass)

    override fun send(to: String, message: String) {
        log.info("\n==================== SMS ====================\nTO: {}\n{}\n==============================================", to, message)
    }
}
