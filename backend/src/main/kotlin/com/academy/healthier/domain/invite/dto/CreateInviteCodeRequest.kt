package com.academy.healthier.domain.invite.dto

import com.academy.healthier.domain.membership.entity.MemberRole
import jakarta.validation.constraints.Min
import jakarta.validation.constraints.NotNull
import java.time.LocalDateTime

data class CreateInviteCodeRequest(
    @field:NotNull(message = "역할은 필수입니다")
    val role: MemberRole,

    @field:Min(0, message = "부여 수강 횟수는 0 이상이어야 합니다")
    val grantedCredits: Int = 0,

    val maxUses: Int? = null,
    val unlimited: Boolean = false,
    val expiresAt: LocalDateTime? = null
)
