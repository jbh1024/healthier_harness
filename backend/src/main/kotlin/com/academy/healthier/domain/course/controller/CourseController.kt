package com.academy.healthier.domain.course.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.course.dto.CourseResponse
import com.academy.healthier.domain.course.dto.CourseScheduleResponse
import com.academy.healthier.domain.course.dto.CreateCourseRequest
import com.academy.healthier.domain.course.dto.CreateScheduleRequest
import com.academy.healthier.domain.course.entity.CourseStatus
import com.academy.healthier.domain.course.service.CourseService
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.security.AcademyAuth
import com.academy.healthier.security.UserPrincipal
import jakarta.validation.Valid
import org.springframework.data.domain.Pageable
import org.springframework.data.web.PageableDefault
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/academies/{academyId}/courses")
class CourseController(
    private val courseService: CourseService
) {

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN, MemberRole.INSTRUCTOR])
    fun createCourse(
        @PathVariable academyId: Long,
        @Valid @RequestBody request: CreateCourseRequest
    ): ApiResponse<CourseResponse> {
        return ApiResponse.ok(courseService.createCourse(academyId, request))
    }

    @GetMapping
    @AcademyAuth
    fun getCourses(
        @PathVariable academyId: Long,
        @RequestParam(required = false) status: CourseStatus?,
        @RequestParam(required = false) keyword: String?,
        @PageableDefault(size = 20) pageable: Pageable
    ): ApiResponse<PageResponse<CourseResponse>> {
        return ApiResponse.ok(courseService.getCourses(academyId, status, keyword, pageable))
    }

    @GetMapping("/{courseId}")
    @AcademyAuth
    fun getCourseDetail(
        @PathVariable academyId: Long,
        @PathVariable courseId: Long
    ): ApiResponse<CourseResponse> {
        return ApiResponse.ok(courseService.getCourseDetail(courseId))
    }

    @PostMapping("/{courseId}/schedules")
    @ResponseStatus(HttpStatus.CREATED)
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN, MemberRole.INSTRUCTOR])
    fun createSchedules(
        @PathVariable academyId: Long,
        @PathVariable courseId: Long,
        @Valid @RequestBody request: CreateScheduleRequest
    ): ApiResponse<List<CourseScheduleResponse>> {
        return ApiResponse.ok(courseService.createSchedules(courseId, request))
    }

    @GetMapping("/calendar")
    @AcademyAuth
    fun getCalendar(
        @PathVariable academyId: Long,
        @RequestParam yearMonth: String
    ): ApiResponse<List<CourseScheduleResponse>> {
        return ApiResponse.ok(courseService.getCalendar(academyId, yearMonth))
    }
}
