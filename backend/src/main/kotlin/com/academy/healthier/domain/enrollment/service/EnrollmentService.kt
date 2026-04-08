package com.academy.healthier.domain.enrollment.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.course.entity.CourseStatus
import com.academy.healthier.domain.course.entity.EnrollmentType
import com.academy.healthier.domain.course.repository.CourseRepository
import com.academy.healthier.domain.enrollment.dto.EnrollmentApprovalRequest
import com.academy.healthier.domain.enrollment.dto.EnrollmentDetailResponse
import com.academy.healthier.domain.enrollment.dto.EnrollmentResponse
import com.academy.healthier.domain.enrollment.entity.Enrollment
import com.academy.healthier.domain.enrollment.entity.EnrollmentStatus
import com.academy.healthier.domain.enrollment.repository.EnrollmentRepository
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class EnrollmentService(
    private val enrollmentRepository: EnrollmentRepository,
    private val courseRepository: CourseRepository,
    private val academyMemberRepository: AcademyMemberRepository,
    private val creditService: CreditService
) {

    @Transactional
    fun enroll(academyId: Long, courseId: Long, userId: Long): EnrollmentResponse {
        // 비관적 락으로 Course 조회
        val course = courseRepository.findByIdForUpdate(courseId)
            ?: throw BusinessException(ErrorCode.COURSE_NOT_FOUND)

        if (course.status != CourseStatus.OPEN) {
            throw BusinessException(ErrorCode.COURSE_NOT_OPEN)
        }

        // 멤버십 확인
        val member = academyMemberRepository.findByAcademyIdAndUserId(academyId, userId)
            ?: throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)

        // 중복 신청 체크
        if (enrollmentRepository.existsByCourseIdAndMemberId(courseId, member.id)) {
            throw BusinessException(ErrorCode.DUPLICATE_ENROLLMENT)
        }

        // 잔여 횟수 확인
        if (member.remainingCredits < 1) {
            throw BusinessException(ErrorCode.INSUFFICIENT_CREDITS)
        }

        // 정원 확인
        if (course.isFull()) {
            // 대기열 등록
            val waitlistCount = enrollmentRepository.countByCourseIdAndStatus(courseId, EnrollmentStatus.WAITLISTED)
            val enrollment = enrollmentRepository.save(
                Enrollment(
                    course = course,
                    member = member,
                    status = EnrollmentStatus.WAITLISTED,
                    waitlistPosition = waitlistCount + 1
                )
            )
            return EnrollmentResponse.from(enrollment)
        }

        // 수강신청 타입별 분기
        val enrollment = when (course.enrollmentType) {
            EnrollmentType.AUTO_APPROVE -> {
                val e = enrollmentRepository.save(
                    Enrollment(course = course, member = member, status = EnrollmentStatus.APPROVED)
                )
                course.incrementEnrollment()
                creditService.deduct(member, e.id)
                e
            }
            EnrollmentType.MANUAL_APPROVE -> {
                enrollmentRepository.save(
                    Enrollment(course = course, member = member, status = EnrollmentStatus.PENDING)
                )
            }
        }

        return EnrollmentResponse.from(enrollment)
    }

    @Transactional
    fun processApproval(enrollmentId: Long, request: EnrollmentApprovalRequest): EnrollmentResponse {
        val enrollment = enrollmentRepository.findById(enrollmentId)
            .orElseThrow { BusinessException(ErrorCode.ENROLLMENT_NOT_FOUND) }

        if (enrollment.status != EnrollmentStatus.PENDING) {
            throw BusinessException(ErrorCode.INVALID_INPUT)
        }

        if (request.approved) {
            enrollment.status = EnrollmentStatus.APPROVED
            val course = courseRepository.findByIdForUpdate(enrollment.course.id)!!
            course.incrementEnrollment()
            creditService.deduct(enrollment.member, enrollment.id)
        } else {
            enrollment.status = EnrollmentStatus.REJECTED
        }

        return EnrollmentResponse.from(enrollment)
    }

    fun getMyEnrollments(academyId: Long, userId: Long): List<EnrollmentResponse> {
        val member = academyMemberRepository.findByAcademyIdAndUserId(academyId, userId)
            ?: throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)

        return enrollmentRepository.findByMemberIdWithCourse(member.id)
            .map { EnrollmentResponse.from(it) }
    }

    fun getCourseEnrollments(courseId: Long, pageable: Pageable): PageResponse<EnrollmentDetailResponse> {
        val page = enrollmentRepository.findByCourseIdWithMember(courseId, pageable)
        return PageResponse.from(page) { EnrollmentDetailResponse.from(it) }
    }
}
