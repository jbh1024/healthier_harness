package com.academy.healthier.domain.course.dto

import jakarta.validation.constraints.NotNull
import java.time.DayOfWeek
import java.time.LocalDate
import java.time.LocalTime

data class CreateScheduleRequest(
    @field:NotNull(message = "시작 시간은 필수입니다")
    val startTime: LocalTime,

    @field:NotNull(message = "종료 시간은 필수입니다")
    val endTime: LocalTime,

    // 단일 일정
    val scheduleDate: LocalDate? = null,

    // 반복 일정 (월별)
    val yearMonth: String? = null,          // "2026-04"
    val repeatDays: List<DayOfWeek>? = null  // [MONDAY, WEDNESDAY, FRIDAY]
)
