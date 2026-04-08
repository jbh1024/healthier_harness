package com.academy.healthier.domain.invite.dto

import com.academy.healthier.domain.invite.entity.InviteCode
import java.time.LocalDateTime

data class InviteCodeResponse(
    val id: Long,
    val code: String,
    val role: String,
    val grantedCredits: Int,
    val maxUses: Int?,
    val currentUses: Int,
    val unlimited: Boolean,
    val expiresAt: LocalDateTime?,
    val isActive: Boolean
) {
    companion object {
        fun from(entity: InviteCode): InviteCodeResponse = InviteCodeResponse(
            id = entity.id,
            code = entity.code,
            role = entity.role.name,
            grantedCredits = entity.grantedCredits,
            maxUses = entity.maxUses,
            currentUses = entity.currentUses,
            unlimited = entity.unlimited,
            expiresAt = entity.expiresAt,
            isActive = entity.isActive
        )
    }
}
