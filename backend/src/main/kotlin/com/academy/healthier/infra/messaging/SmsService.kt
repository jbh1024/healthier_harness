package com.academy.healthier.infra.messaging

interface SmsService {
    fun send(to: String, message: String)
}
