package com.academy.healthier.domain.invite.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.academy.repository.AcademyRepository
import com.academy.healthier.domain.invite.dto.CreateInviteCodeRequest
import com.academy.healthier.domain.invite.dto.InviteCodeResponse
import com.academy.healthier.domain.invite.entity.InviteCode
import com.academy.healthier.domain.invite.repository.InviteCodeRepository
import com.academy.healthier.domain.membership.entity.AcademyMember
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import com.academy.healthier.domain.user.repository.UserRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import kotlin.random.Random

@Service
@Transactional(readOnly = true)
class InviteCodeService(
    private val inviteCodeRepository: InviteCodeRepository,
    private val academyRepository: AcademyRepository,
    private val academyMemberRepository: AcademyMemberRepository,
    private val userRepository: UserRepository
) {

    @Transactional
    fun createInviteCode(
        academyId: Long,
        userId: Long,
        request: CreateInviteCodeRequest
    ): InviteCodeResponse {
        val academy = academyRepository.findById(academyId)
            .orElseThrow { BusinessException(ErrorCode.ACADEMY_NOT_FOUND) }
        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        val code = generateUniqueCode()

        val inviteCode = inviteCodeRepository.save(
            InviteCode(
                academy = academy,
                code = code,
                role = request.role,
                grantedCredits = request.grantedCredits,
                maxUses = request.maxUses,
                unlimited = request.unlimited,
                expiresAt = request.expiresAt,
                createdBy = user
            )
        )

        return InviteCodeResponse.from(inviteCode)
    }

    fun getInviteCodes(academyId: Long, pageable: Pageable): PageResponse<InviteCodeResponse> {
        val page = inviteCodeRepository.findByAcademyId(academyId, pageable)
        return PageResponse.from(page) { InviteCodeResponse.from(it) }
    }

    @Transactional
    fun joinAcademy(userId: Long, code: String) {
        val inviteCode = inviteCodeRepository.findByCode(code)
            ?: throw BusinessException(ErrorCode.INVITE_CODE_NOT_FOUND)

        if (!inviteCode.isUsable()) {
            if (inviteCode.expiresAt != null && java.time.LocalDateTime.now().isAfter(inviteCode.expiresAt)) {
                throw BusinessException(ErrorCode.INVITE_CODE_EXPIRED)
            }
            throw BusinessException(ErrorCode.INVITE_CODE_EXHAUSTED)
        }

        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        if (academyMemberRepository.existsByAcademyIdAndUserId(inviteCode.academy.id, userId)) {
            throw BusinessException(ErrorCode.ALREADY_MEMBER)
        }

        academyMemberRepository.save(
            AcademyMember(
                academy = inviteCode.academy,
                user = user,
                role = inviteCode.role,
                remainingCredits = inviteCode.grantedCredits
            )
        )

        inviteCode.use()
    }

    private fun generateUniqueCode(): String {
        val chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        repeat(10) {
            val code = (1..6).map { chars[Random.nextInt(chars.length)] }.joinToString("")
            if (inviteCodeRepository.findByCode(code) == null) return code
        }
        throw BusinessException(ErrorCode.INTERNAL_ERROR)
    }
}
