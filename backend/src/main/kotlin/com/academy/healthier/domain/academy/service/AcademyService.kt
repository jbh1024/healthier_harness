package com.academy.healthier.domain.academy.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.academy.dto.AcademyResponse
import com.academy.healthier.domain.academy.dto.CreateAcademyRequest
import com.academy.healthier.domain.academy.entity.Academy
import com.academy.healthier.domain.academy.repository.AcademyRepository
import com.academy.healthier.domain.membership.entity.AcademyMember
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import com.academy.healthier.domain.user.repository.UserRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class AcademyService(
    private val academyRepository: AcademyRepository,
    private val academyMemberRepository: AcademyMemberRepository,
    private val userRepository: UserRepository
) {

    @Transactional
    fun createAcademy(request: CreateAcademyRequest): AcademyResponse {
        val adminUser = userRepository.findById(request.adminUserId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        val academy = academyRepository.save(
            Academy(
                name = request.name,
                description = request.description,
                contactInfo = request.contactInfo
            )
        )

        academyMemberRepository.save(
            AcademyMember(
                academy = academy,
                user = adminUser,
                role = MemberRole.ACADEMY_ADMIN
            )
        )

        return AcademyResponse.from(academy)
    }

    fun getMyAcademies(userId: Long, isSystemAdmin: Boolean): List<AcademyResponse> {
        if (isSystemAdmin) {
            return academyRepository.findAll().map { AcademyResponse.from(it) }
        }
        return academyMemberRepository.findByUserIdWithAcademy(userId)
            .map { AcademyResponse.from(it.academy) }
    }

    fun getAcademyDetail(academyId: Long, userId: Long, isSystemAdmin: Boolean): AcademyResponse {
        val academy = academyRepository.findById(academyId)
            .orElseThrow { BusinessException(ErrorCode.ACADEMY_NOT_FOUND) }

        if (!isSystemAdmin && !academyMemberRepository.existsByAcademyIdAndUserId(academyId, userId)) {
            throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)
        }

        return AcademyResponse.from(academy)
    }
}
