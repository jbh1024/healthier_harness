package com.academy.healthier.domain.user.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import com.academy.healthier.domain.user.dto.UpdateProfileRequest
import com.academy.healthier.domain.user.dto.UserAcademyResponse
import com.academy.healthier.domain.user.dto.UserResponse
import com.academy.healthier.domain.user.repository.UserRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class UserService(
    private val userRepository: UserRepository,
    private val academyMemberRepository: AcademyMemberRepository
) {

    fun getMyProfile(userId: Long): UserResponse {
        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        val memberships = academyMemberRepository.findByUserIdWithAcademy(userId)
        val academies = memberships.map { member ->
            UserAcademyResponse(
                academyId = member.academy.id,
                academyName = member.academy.name,
                role = member.role.name,
                remainingCredits = member.remainingCredits
            )
        }

        return UserResponse.from(user, academies)
    }

    @Transactional
    fun updateProfile(userId: Long, request: UpdateProfileRequest): UserResponse {
        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }
        request.name?.let { user.name = it }
        request.phone?.let { user.phone = it }
        return getMyProfile(userId)
    }
}
