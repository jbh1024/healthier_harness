package com.academy.healthier.domain.course.repository

import com.academy.healthier.domain.course.entity.CourseSchedule
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import java.time.LocalDate

interface CourseScheduleRepository : JpaRepository<CourseSchedule, Long> {

    fun findByCourseId(courseId: Long): List<CourseSchedule>

    @Query("""
        SELECT cs FROM CourseSchedule cs
        JOIN FETCH cs.course c
        JOIN FETCH c.instructor i
        JOIN FETCH i.user
        WHERE c.academy.id = :academyId
        AND cs.scheduleDate BETWEEN :startDate AND :endDate
        ORDER BY cs.scheduleDate, cs.startTime
    """)
    fun findByAcademyIdAndDateRange(
        academyId: Long,
        startDate: LocalDate,
        endDate: LocalDate
    ): List<CourseSchedule>
}
