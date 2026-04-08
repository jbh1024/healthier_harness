package com.academy.healthier.domain.invite.entity

import com.academy.healthier.common.entity.BaseEntity
import com.academy.healthier.domain.academy.entity.Academy
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.user.entity.User
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.EnumType
import jakarta.persistence.Enumerated
import jakarta.persistence.FetchType
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table
import java.time.LocalDateTime

@Entity
@Table(name = "invite_codes")
class InviteCode(
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "academy_id", nullable = false)
    val academy: Academy,

    @Column(nullable = false, unique = true, length = 20)
    val code: String,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    val role: MemberRole,

    @Column(name = "granted_credits", nullable = false)
    val grantedCredits: Int = 0,

    @Column(name = "max_uses")
    val maxUses: Int? = null,

    @Column(name = "current_uses", nullable = false)
    var currentUses: Int = 0,

    @Column(nullable = false)
    val unlimited: Boolean = false,

    @Column(name = "expires_at")
    val expiresAt: LocalDateTime? = null,

    @Column(name = "is_active", nullable = false)
    var isActive: Boolean = true,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by", nullable = false)
    val createdBy: User
) : BaseEntity() {

    fun isUsable(): Boolean {
        if (!isActive) return false
        if (expiresAt != null && LocalDateTime.now().isAfter(expiresAt)) return false
        val max = maxUses
        if (!unlimited && max != null && currentUses >= max) return false
        return true
    }

    fun use() {
        currentUses++
    }
}
