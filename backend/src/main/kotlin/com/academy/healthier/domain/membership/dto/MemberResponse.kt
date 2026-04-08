package com.academy.healthier.domain.membership.dto

import com.academy.healthier.domain.membership.entity.AcademyMember

data class MemberResponse(
    val id: Long,
    val userId: Long,
    val userName: String,
    val email: String,
    val role: String,
    val remainingCredits: Int
) {
    companion object {
        fun from(member: AcademyMember): MemberResponse = MemberResponse(
            id = member.id,
            userId = member.user.id,
            userName = member.user.name,
            email = member.user.email,
            role = member.role.name,
            remainingCredits = member.remainingCredits
        )
    }
}
