package com.academy.healthier.security.jwt

import org.springframework.boot.context.properties.ConfigurationProperties

@ConfigurationProperties(prefix = "jwt")
data class JwtProperties(
    val secret: String,
    val accessExpiry: Long = 3600000,      // 1시간
    val refreshExpiry: Long = 1209600000   // 14일
)
