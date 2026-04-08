package com.academy.healthier.domain.enrollment.dto

import jakarta.validation.constraints.NotNull

data class EnrollmentApprovalRequest(
    @field:NotNull(message = "승인 여부는 필수입니다")
    val approved: Boolean
)
