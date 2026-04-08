package com.academy.healthier.domain.enrollment.service

import com.academy.healthier.domain.enrollment.entity.CreditHistory
import com.academy.healthier.domain.enrollment.entity.CreditReason
import com.academy.healthier.domain.enrollment.repository.CreditHistoryRepository
import com.academy.healthier.domain.membership.entity.AcademyMember
import org.springframework.stereotype.Service

@Service
class CreditService(
    private val creditHistoryRepository: CreditHistoryRepository
) {

    fun deduct(member: AcademyMember, referenceId: Long) {
        member.remainingCredits--
        creditHistoryRepository.save(
            CreditHistory(
                member = member,
                changeAmount = -1,
                reason = CreditReason.ENROLLMENT,
                referenceId = referenceId
            )
        )
    }

    fun restore(member: AcademyMember, referenceId: Long) {
        member.remainingCredits++
        creditHistoryRepository.save(
            CreditHistory(
                member = member,
                changeAmount = 1,
                reason = CreditReason.CANCELLATION,
                referenceId = referenceId
            )
        )
    }
}
