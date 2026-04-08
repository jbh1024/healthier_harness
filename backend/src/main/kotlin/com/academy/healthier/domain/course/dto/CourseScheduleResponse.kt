package com.academy.healthier.domain.course.dto

import com.academy.healthier.domain.course.entity.CourseSchedule
import java.time.LocalDate
import java.time.LocalTime

data class CourseScheduleResponse(
    val id: Long,
    val courseId: Long,
    val courseTitle: String,
    val instructorName: String,
    val scheduleDate: LocalDate,
    val startTime: LocalTime,
    val endTime: LocalTime
) {
    companion object {
        fun from(schedule: CourseSchedule): CourseScheduleResponse = CourseScheduleResponse(
            id = schedule.id,
            courseId = schedule.course.id,
            courseTitle = schedule.course.title,
            instructorName = schedule.course.instructor.user.name,
            scheduleDate = schedule.scheduleDate,
            startTime = schedule.startTime,
            endTime = schedule.endTime
        )
    }
}
