package com.academy.healthier.domain.course.repository

import com.academy.healthier.domain.course.entity.Course
import com.academy.healthier.domain.course.entity.CourseStatus
import jakarta.persistence.LockModeType
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Lock
import org.springframework.data.jpa.repository.Query

interface CourseRepository : JpaRepository<Course, Long> {

    @Query("""
        SELECT c FROM Course c
        JOIN FETCH c.instructor i
        JOIN FETCH i.user
        WHERE c.academy.id = :academyId
        AND (:status IS NULL OR c.status = :status)
        AND (:keyword IS NULL OR c.title LIKE %:keyword% OR c.description LIKE %:keyword%)
    """,
        countQuery = """
        SELECT COUNT(c) FROM Course c
        WHERE c.academy.id = :academyId
        AND (:status IS NULL OR c.status = :status)
        AND (:keyword IS NULL OR c.title LIKE %:keyword% OR c.description LIKE %:keyword%)
    """)
    fun findByAcademyIdWithFilters(
        academyId: Long,
        status: CourseStatus?,
        keyword: String?,
        pageable: Pageable
    ): Page<Course>

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT c FROM Course c WHERE c.id = :courseId")
    fun findByIdForUpdate(courseId: Long): Course?

    @Query("SELECT c FROM Course c JOIN FETCH c.instructor i JOIN FETCH i.user WHERE c.id = :courseId")
    fun findByIdWithInstructor(courseId: Long): Course?
}
