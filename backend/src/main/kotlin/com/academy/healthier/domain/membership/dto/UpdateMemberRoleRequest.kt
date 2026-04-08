package com.academy.healthier.domain.membership.dto

import com.academy.healthier.domain.membership.entity.MemberRole
import jakarta.validation.constraints.NotNull

data class UpdateMemberRoleRequest(
    @field:NotNull(message = "역할은 필수입니다")
    val role: MemberRole
)
