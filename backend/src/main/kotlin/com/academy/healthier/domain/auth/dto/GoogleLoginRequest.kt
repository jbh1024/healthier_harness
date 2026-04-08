package com.academy.healthier.domain.auth.dto

import jakarta.validation.constraints.NotBlank

data class GoogleLoginRequest(
    @field:NotBlank(message = "Google ID Token은 필수입니다")
    val idToken: String
)
