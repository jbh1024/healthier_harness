package com.academy.healthier.domain.academy.dto

import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.Size

data class CreateAcademyRequest(
    @field:NotBlank(message = "학원 이름은 필수입니다")
    @field:Size(max = 100, message = "학원 이름은 100자 이하여야 합니다")
    val name: String,

    val description: String? = null,
    val contactInfo: String? = null,

    val adminUserId: Long
)
