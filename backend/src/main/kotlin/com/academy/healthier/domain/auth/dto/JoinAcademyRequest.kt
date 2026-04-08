package com.academy.healthier.domain.auth.dto

import jakarta.validation.constraints.NotBlank

data class JoinAcademyRequest(
    @field:NotBlank(message = "초대코드는 필수입니다")
    val inviteCode: String
)
