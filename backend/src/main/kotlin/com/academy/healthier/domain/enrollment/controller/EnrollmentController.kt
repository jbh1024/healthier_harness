package com.academy.healthier.domain.enrollment.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.enrollment.dto.EnrollmentApprovalRequest
import com.academy.healthier.domain.enrollment.dto.EnrollmentDetailResponse
import com.academy.healthier.domain.enrollment.dto.EnrollmentResponse
import com.academy.healthier.domain.enrollment.service.EnrollmentService
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
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/academies/{academyId}")
class EnrollmentController(
    private val enrollmentService: EnrollmentService
) {

    @PostMapping("/courses/{courseId}/enrollments")
    @ResponseStatus(HttpStatus.CREATED)
    @AcademyAuth(roles = [MemberRole.STUDENT])
    fun enroll(
        @PathVariable academyId: Long,
        @PathVariable courseId: Long,
        @CurrentUser user: UserPrincipal
    ): ApiResponse<EnrollmentResponse> {
        return ApiResponse.ok(enrollmentService.enroll(academyId, courseId, user.userId))
    }

    @GetMapping("/courses/{courseId}/enrollments")
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN, MemberRole.INSTRUCTOR])
    fun getCourseEnrollments(
        @PathVariable academyId: Long,
        @PathVariable courseId: Long,
        @PageableDefault(size = 20) pageable: Pageable
    ): ApiResponse<PageResponse<EnrollmentDetailResponse>> {
        return ApiResponse.ok(enrollmentService.getCourseEnrollments(courseId, pageable))
    }

    @PutMapping("/enrollments/{enrollmentId}/approval")
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN, MemberRole.INSTRUCTOR])
    fun processApproval(
        @PathVariable academyId: Long,
        @PathVariable enrollmentId: Long,
        @Valid @RequestBody request: EnrollmentApprovalRequest
    ): ApiResponse<EnrollmentResponse> {
        return ApiResponse.ok(enrollmentService.processApproval(enrollmentId, request))
    }

    @GetMapping("/enrollments/me")
    @AcademyAuth
    fun getMyEnrollments(
        @PathVariable academyId: Long,
        @CurrentUser user: UserPrincipal
    ): ApiResponse<List<EnrollmentResponse>> {
        return ApiResponse.ok(enrollmentService.getMyEnrollments(academyId, user.userId))
    }
}
