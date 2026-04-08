package com.academy.healthier.domain.course.dto

import com.academy.healthier.domain.course.entity.Course

data class CourseResponse(
    val id: Long,
    val title: String,
    val description: String?,
    val instructorName: String,
    val maxCapacity: Int,
    val currentEnrollment: Int,
    val enrollmentType: String,
    val status: String
) {
    companion object {
        fun from(course: Course): CourseResponse = CourseResponse(
            id = course.id,
            title = course.title,
            description = course.description,
            instructorName = course.instructor.user.name,
            maxCapacity = course.maxCapacity,
            currentEnrollment = course.currentEnrollment,
            enrollmentType = course.enrollmentType.name,
            status = course.status.name
        )
    }
}
