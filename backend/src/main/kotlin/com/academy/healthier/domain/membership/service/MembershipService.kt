package com.academy.healthier.domain.membership.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.enrollment.entity.CreditHistory
import com.academy.healthier.domain.enrollment.entity.CreditReason
import com.academy.healthier.domain.enrollment.repository.CreditHistoryRepository
import com.academy.healthier.domain.membership.dto.MemberResponse
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class MembershipService(
    private val academyMemberRepository: AcademyMemberRepository,
    private val creditHistoryRepository: CreditHistoryRepository
) {

    fun getMembers(academyId: Long, pageable: Pageable): PageResponse<MemberResponse> {
        val page = academyMemberRepository.findByAcademyIdWithUser(academyId, pageable)
        return PageResponse.from(page) { MemberResponse.from(it) }
    }

    @Transactional
    fun updateMemberRole(academyId: Long, memberId: Long, role: MemberRole) {
        val member = academyMemberRepository.findById(memberId)
            .orElseThrow { BusinessException(ErrorCode.NOT_ACADEMY_MEMBER) }
        if (member.academy.id != academyId) throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)
        member.role = role
    }

    @Transactional
    fun removeMember(academyId: Long, memberId: Long, requesterId: Long) {
        val member = academyMemberRepository.findById(memberId)
            .orElseThrow { BusinessException(ErrorCode.NOT_ACADEMY_MEMBER) }
        if (member.academy.id != academyId) throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)
        // 자기 자신(관리자) 제거 방지
        if (member.user.id == requesterId) throw BusinessException(ErrorCode.INVALID_INPUT)
        academyMemberRepository.delete(member)
    }

    @Transactional
    fun chargeCredits(academyId: Long, memberId: Long, amount: Int) {
        val member = academyMemberRepository.findById(memberId)
            .orElseThrow { BusinessException(ErrorCode.NOT_ACADEMY_MEMBER) }
        if (member.academy.id != academyId) throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)
        member.remainingCredits += amount
        creditHistoryRepository.save(
            CreditHistory(
                member = member,
                changeAmount = amount,
                reason = CreditReason.MANUAL_CHARGE
            )
        )
    }
}
