package com.academy.healthier.domain.course.dto

import com.academy.healthier.domain.course.entity.EnrollmentType
import jakarta.validation.constraints.Min
import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.Size

data class CreateCourseRequest(
    @field:NotBlank(message = "수업 제목은 필수입니다")
    @field:Size(max = 200, message = "수업 제목은 200자 이하여야 합니다")
    val title: String,

    val description: String? = null,

    @field:Min(1, message = "정원은 1명 이상이어야 합니다")
    val maxCapacity: Int = 20,

    val enrollmentType: EnrollmentType = EnrollmentType.AUTO_APPROVE,

    val instructorMemberId: Long
)
