package com.academy.healthier.domain.membership.dto

import jakarta.validation.constraints.Min

data class ChargeCreditRequest(
    @field:Min(1, message = "충전 횟수는 1 이상이어야 합니다")
    val amount: Int
)
