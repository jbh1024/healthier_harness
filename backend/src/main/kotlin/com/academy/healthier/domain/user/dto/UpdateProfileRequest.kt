package com.academy.healthier.domain.user.dto

import jakarta.validation.constraints.Size

data class UpdateProfileRequest(
    @field:Size(max = 50, message = "이름은 50자 이하여야 합니다")
    val name: String? = null,
    val phone: String? = null
)
