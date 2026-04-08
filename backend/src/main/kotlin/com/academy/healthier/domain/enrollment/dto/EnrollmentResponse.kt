package com.academy.healthier.domain.enrollment.dto

import com.academy.healthier.domain.enrollment.entity.Enrollment

data class EnrollmentResponse(
    val id: Long,
    val courseId: Long,
    val courseTitle: String,
    val status: String,
    val waitlistPosition: Int?
) {
    companion object {
        fun from(enrollment: Enrollment): EnrollmentResponse = EnrollmentResponse(
            id = enrollment.id,
            courseId = enrollment.course.id,
            courseTitle = enrollment.course.title,
            status = enrollment.status.name,
            waitlistPosition = enrollment.waitlistPosition
        )
    }
}

data class EnrollmentDetailResponse(
    val id: Long,
    val memberId: Long,
    val memberName: String,
    val memberEmail: String,
    val status: String,
    val waitlistPosition: Int?
) {
    companion object {
        fun from(enrollment: Enrollment): EnrollmentDetailResponse = EnrollmentDetailResponse(
            id = enrollment.id,
            memberId = enrollment.member.id,
            memberName = enrollment.member.user.name,
            memberEmail = enrollment.member.user.email,
            status = enrollment.status.name,
            waitlistPosition = enrollment.waitlistPosition
        )
    }
}
