package com.academy.healthier.infra.messaging

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service

@Service
class ConsoleEmailService : EmailService {
    private val log = LoggerFactory.getLogger(javaClass)

    override fun send(to: String, subject: String, body: String) {
        log.info(
            "\n==================== EMAIL ====================\n" +
                "TO: {}\nSUBJECT: {}\n-----------------------------------------------\n{}\n" +
                "================================================",
            to, subject, body
        )
    }
}
