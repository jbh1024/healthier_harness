package com.academy.healthier.domain.user.dto

import com.academy.healthier.domain.user.entity.User

data class UserResponse(
    val id: Long,
    val email: String,
    val name: String,
    val phone: String?,
    val profileImageUrl: String?,
    val thumbnailImageUrl: String?,
    val academies: List<UserAcademyResponse>
) {
    companion object {
        fun from(user: User, academies: List<UserAcademyResponse>): UserResponse = UserResponse(
            id = user.id,
            email = user.email,
            name = user.name,
            phone = user.phone,
            profileImageUrl = user.profileImageUrl,
            thumbnailImageUrl = user.thumbnailImageUrl,
            academies = academies
        )
    }
}

data class UserAcademyResponse(
    val academyId: Long,
    val academyName: String,
    val role: String,
    val remainingCredits: Int
)
