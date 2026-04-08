package com.academy.healthier.domain.course.dto

import jakarta.validation.constraints.Size

data class UpdateCourseRequest(
    @field:Size(max = 200, message = "수업 제목은 200자 이하여야 합니다")
    val title: String? = null,
    val description: String? = null,
    val maxCapacity: Int? = null
)
