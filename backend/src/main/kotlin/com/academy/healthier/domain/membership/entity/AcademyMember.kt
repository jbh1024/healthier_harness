package com.academy.healthier.domain.membership.entity

import com.academy.healthier.common.entity.BaseEntity
import com.academy.healthier.domain.academy.entity.Academy
import com.academy.healthier.domain.user.entity.User
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
    name = "academy_members",
    uniqueConstraints = [UniqueConstraint(columnNames = ["academy_id", "user_id"])]
)
class AcademyMember(
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "academy_id", nullable = false)
    val academy: Academy,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    val user: User,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    var role: MemberRole,

    @Column(name = "remaining_credits", nullable = false)
    var remainingCredits: Int = 0
) : BaseEntity()
