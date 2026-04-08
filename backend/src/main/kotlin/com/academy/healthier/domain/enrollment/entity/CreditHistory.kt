package com.academy.healthier.domain.enrollment.entity

import com.academy.healthier.domain.membership.entity.AcademyMember
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.EnumType
import jakarta.persistence.Enumerated
import jakarta.persistence.FetchType
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table
import java.time.LocalDateTime

@Entity
@Table(name = "credit_histories")
class CreditHistory(
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    val member: AcademyMember,

    @Column(name = "change_amount", nullable = false)
    val changeAmount: Int,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    val reason: CreditReason,

    @Column(name = "reference_id")
    val referenceId: Long? = null,

    @Column(name = "created_at", nullable = false, updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now()
) {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0
}

enum class CreditReason {
    ENROLLMENT,
    CANCELLATION,
    MANUAL_CHARGE,
    INVITE_JOIN
}
