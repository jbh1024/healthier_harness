package com.academy.healthier.domain.academy.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.academy.dto.DashboardResponse
import com.academy.healthier.domain.academy.dto.InstructorStat
import com.academy.healthier.domain.academy.dto.StudentStat
import com.academy.healthier.domain.academy.repository.AcademyRepository
import com.academy.healthier.domain.enrollment.entity.EnrollmentStatus
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import jakarta.persistence.EntityManager
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class DashboardService(
    private val academyRepository: AcademyRepository,
    private val academyMemberRepository: AcademyMemberRepository,
    private val entityManager: EntityManager
) {

    fun getDashboard(academyId: Long): DashboardResponse {
        if (!academyRepository.existsById(academyId)) {
            throw BusinessException(ErrorCode.ACADEMY_NOT_FOUND)
        }

        val totalMembers = entityManager.createQuery(
            "SELECT COUNT(m) FROM AcademyMember m WHERE m.academy.id = :academyId", Long::class.javaObjectType
        ).setParameter("academyId", academyId).singleResult

        val totalCourses = entityManager.createQuery(
            "SELECT COUNT(c) FROM Course c WHERE c.academy.id = :academyId", Long::class.javaObjectType
        ).setParameter("academyId", academyId).singleResult

        val activeEnrollments = entityManager.createQuery(
            """SELECT COUNT(e) FROM Enrollment e
               JOIN e.course c
               WHERE c.academy.id = :academyId AND e.status = :status""",
            Long::class.javaObjectType
        ).setParameter("academyId", academyId)
            .setParameter("status", EnrollmentStatus.APPROVED)
            .singleResult

        val instructorStats = getInstructorStats(academyId)
        val studentStats = getStudentStats(academyId)

        return DashboardResponse(
            totalMembers = totalMembers,
            totalCourses = totalCourses,
            activeEnrollments = activeEnrollments,
            instructorStats = instructorStats,
            studentStats = studentStats
        )
    }

    @Suppress("UNCHECKED_CAST")
    private fun getInstructorStats(academyId: Long): List<InstructorStat> {
        val results = entityManager.createQuery(
            """SELECT m.user.name, COUNT(DISTINCT c.id), COUNT(DISTINCT e.id)
               FROM AcademyMember m
               LEFT JOIN Course c ON c.instructor.id = m.id
               LEFT JOIN Enrollment e ON e.course.id = c.id AND e.status = :status
               WHERE m.academy.id = :academyId AND m.role = :role
               GROUP BY m.id, m.user.name"""
        ).setParameter("academyId", academyId)
            .setParameter("role", MemberRole.INSTRUCTOR)
            .setParameter("status", EnrollmentStatus.APPROVED)
            .resultList as List<Array<Any>>

        return results.map { row ->
            InstructorStat(
                instructorName = row[0] as String,
                courseCount = row[1] as Long,
                totalEnrollments = row[2] as Long
            )
        }
    }

    @Suppress("UNCHECKED_CAST")
    private fun getStudentStats(academyId: Long): List<StudentStat> {
        val results = entityManager.createQuery(
            """SELECT m.user.name, COUNT(e.id)
               FROM AcademyMember m
               LEFT JOIN Enrollment e ON e.member.id = m.id AND e.status = :status
               WHERE m.academy.id = :academyId AND m.role = :role
               GROUP BY m.id, m.user.name
               ORDER BY COUNT(e.id) DESC"""
        ).setParameter("academyId", academyId)
            .setParameter("role", MemberRole.STUDENT)
            .setParameter("status", EnrollmentStatus.APPROVED)
            .setMaxResults(20)
            .resultList as List<Array<Any>>

        return results.map { row ->
            StudentStat(
                studentName = row[0] as String,
                enrolledCourses = row[1] as Long
            )
        }
    }
}
