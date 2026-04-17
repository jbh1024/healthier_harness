package com.academy.healthier.infra.messaging

interface EmailService {
    fun send(to: String, subject: String, body: String)
}
