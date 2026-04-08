package com.academy.healthier.domain.auth.dto

data class TokenResponse(
    val accessToken: String,
    val refreshToken: String
)
