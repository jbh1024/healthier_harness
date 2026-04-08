package com.academy.healthier.domain.enrollment.repository

import com.academy.healthier.domain.enrollment.entity.Enrollment
import com.academy.healthier.domain.enrollment.entity.EnrollmentStatus
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface EnrollmentRepository : JpaRepository<Enrollment, Long> {

    fun existsByCourseIdAndMemberId(courseId: Long, memberId: Long): Boolean

    @Query("""
        SELECT e FROM Enrollment e
        JOIN FETCH e.course c
        JOIN FETCH c.instructor i
        JOIN FETCH i.user
        WHERE e.member.id = :memberId
        ORDER BY e.createdAt DESC
    """)
    fun findByMemberIdWithCourse(memberId: Long): List<Enrollment>

    @Query("""
        SELECT e FROM Enrollment e
        JOIN FETCH e.member m
        JOIN FETCH m.user
        WHERE e.course.id = :courseId
    """,
        countQuery = "SELECT COUNT(e) FROM Enrollment e WHERE e.course.id = :courseId")
    fun findByCourseIdWithMember(courseId: Long, pageable: Pageable): Page<Enrollment>

    fun countByCourseIdAndStatus(courseId: Long, status: EnrollmentStatus): Int

    @Query("""
        SELECT e FROM Enrollment e
        WHERE e.course.id = :courseId AND e.status = 'WAITLISTED'
        ORDER BY e.waitlistPosition ASC
    """)
    fun findWaitlistedByCourseId(courseId: Long): List<Enrollment>
}
