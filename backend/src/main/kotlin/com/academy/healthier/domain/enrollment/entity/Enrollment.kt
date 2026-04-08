package com.academy.healthier.domain.enrollment.entity

import com.academy.healthier.common.entity.BaseEntity
import com.academy.healthier.domain.course.entity.Course
import com.academy.healthier.domain.membership.entity.AcademyMember
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.EnumType
import jakarta.persistence.Enumerated
import jakarta.persistence.FetchType
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table
import jakarta.persistence.UniqueConstraint

@Entity
@Table(
    name = "enrollments",
    uniqueConstraints = [UniqueConstraint(columnNames = ["course_id", "member_id"])]
)
class Enrollment(
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id", nullable = false)
    val course: Course,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    val member: AcademyMember,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    var status: EnrollmentStatus,

    @Column(name = "waitlist_position")
    var waitlistPosition: Int? = null
) : BaseEntity()
