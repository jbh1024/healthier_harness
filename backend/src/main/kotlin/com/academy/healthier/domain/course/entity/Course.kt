package com.academy.healthier.domain.course.entity

import com.academy.healthier.common.entity.BaseEntity
import com.academy.healthier.domain.academy.entity.Academy
import com.academy.healthier.domain.membership.entity.AcademyMember
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.EnumType
import jakarta.persistence.Enumerated
import jakarta.persistence.FetchType
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table

@Entity
@Table(name = "courses")
class Course(
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "academy_id", nullable = false)
    val academy: Academy,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "instructor_id", nullable = false)
    val instructor: AcademyMember,

    @Column(nullable = false, length = 200)
    var title: String,

    @Column(columnDefinition = "TEXT")
    var description: String? = null,

    @Column(name = "max_capacity", nullable = false)
    var maxCapacity: Int = 20,

    @Column(name = "current_enrollment", nullable = false)
    var currentEnrollment: Int = 0,

    @Enumerated(EnumType.STRING)
    @Column(name = "enrollment_type", nullable = false, length = 20)
    var enrollmentType: EnrollmentType = EnrollmentType.AUTO_APPROVE,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    var status: CourseStatus = CourseStatus.OPEN
) : BaseEntity() {

    fun isFull(): Boolean = currentEnrollment >= maxCapacity

    fun incrementEnrollment() {
        currentEnrollment++
    }

    fun decrementEnrollment() {
        if (currentEnrollment > 0) currentEnrollment--
    }
}
