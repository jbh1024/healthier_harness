package com.academy.healthier.domain.academy.dto

data class DashboardResponse(
    val totalMembers: Long,
    val totalCourses: Long,
    val activeEnrollments: Long,
    val instructorStats: List<InstructorStat>,
    val studentStats: List<StudentStat>
)

data class InstructorStat(
    val instructorName: String,
    val courseCount: Long,
    val totalEnrollments: Long
)

data class StudentStat(
    val studentName: String,
    val enrolledCourses: Long
)
