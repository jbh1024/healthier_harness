package com.academy.healthier.domain.course.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.academy.repository.AcademyRepository
import com.academy.healthier.domain.course.dto.CourseResponse
import com.academy.healthier.domain.course.dto.CourseScheduleResponse
import com.academy.healthier.domain.course.dto.CreateCourseRequest
import com.academy.healthier.domain.course.dto.CreateScheduleRequest
import com.academy.healthier.domain.course.entity.Course
import com.academy.healthier.domain.course.entity.CourseSchedule
import com.academy.healthier.domain.course.entity.CourseStatus
import com.academy.healthier.domain.course.repository.CourseRepository
import com.academy.healthier.domain.course.repository.CourseScheduleRepository
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDate
import java.time.YearMonth

@Service
@Transactional(readOnly = true)
class CourseService(
    private val courseRepository: CourseRepository,
    private val courseScheduleRepository: CourseScheduleRepository,
    private val academyRepository: AcademyRepository,
    private val academyMemberRepository: AcademyMemberRepository
) {

    @Transactional
    fun createCourse(academyId: Long, request: CreateCourseRequest): CourseResponse {
        val academy = academyRepository.findById(academyId)
            .orElseThrow { BusinessException(ErrorCode.ACADEMY_NOT_FOUND) }

        val instructor = academyMemberRepository.findById(request.instructorMemberId)
            .orElseThrow { BusinessException(ErrorCode.NOT_ACADEMY_MEMBER) }

        val course = courseRepository.save(
            Course(
                academy = academy,
                instructor = instructor,
                title = request.title,
                description = request.description,
                maxCapacity = request.maxCapacity,
                enrollmentType = request.enrollmentType
            )
        )

        return CourseResponse.from(course)
    }

    fun getCourses(
        academyId: Long,
        status: CourseStatus?,
        keyword: String?,
        pageable: Pageable
    ): PageResponse<CourseResponse> {
        val page = courseRepository.findByAcademyIdWithFilters(academyId, status, keyword, pageable)
        return PageResponse.from(page) { CourseResponse.from(it) }
    }

    fun getCourseDetail(courseId: Long): CourseResponse {
        val course = courseRepository.findByIdWithInstructor(courseId)
            ?: throw BusinessException(ErrorCode.COURSE_NOT_FOUND)
        return CourseResponse.from(course)
    }

    @Transactional
    fun createSchedules(courseId: Long, request: CreateScheduleRequest): List<CourseScheduleResponse> {
        val course = courseRepository.findById(courseId)
            .orElseThrow { BusinessException(ErrorCode.COURSE_NOT_FOUND) }

        val dates = resolveScheduleDates(request)

        val schedules = dates.map { date ->
            CourseSchedule(
                course = course,
                scheduleDate = date,
                startTime = request.startTime,
                endTime = request.endTime
            )
        }

        return courseScheduleRepository.saveAll(schedules)
            .map { CourseScheduleResponse.from(it) }
    }

    fun getCalendar(academyId: Long, yearMonth: String): List<CourseScheduleResponse> {
        val ym = YearMonth.parse(yearMonth)
        val startDate = ym.atDay(1)
        val endDate = ym.atEndOfMonth()

        return courseScheduleRepository.findByAcademyIdAndDateRange(academyId, startDate, endDate)
            .map { CourseScheduleResponse.from(it) }
    }

    private fun resolveScheduleDates(request: CreateScheduleRequest): List<LocalDate> {
        // 단일 일정
        if (request.scheduleDate != null) {
            return listOf(request.scheduleDate)
        }

        // 반복 일정 (월별)
        if (request.yearMonth != null && !request.repeatDays.isNullOrEmpty()) {
            val ym = YearMonth.parse(request.yearMonth)
            val dates = mutableListOf<LocalDate>()
            var date = ym.atDay(1)
            val endDate = ym.atEndOfMonth()

            while (!date.isAfter(endDate)) {
                if (date.dayOfWeek in request.repeatDays) {
                    dates.add(date)
                }
                date = date.plusDays(1)
            }
            return dates
        }

        throw BusinessException(ErrorCode.INVALID_INPUT)
    }
}
