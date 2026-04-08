package com.academy.healthier.domain.membership.service

import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.membership.dto.MemberResponse
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class MembershipService(
    private val academyMemberRepository: AcademyMemberRepository
) {

    fun getMembers(academyId: Long, pageable: Pageable): PageResponse<MemberResponse> {
        val page = academyMemberRepository.findByAcademyIdWithUser(academyId, pageable)
        return PageResponse.from(page) { MemberResponse.from(it) }
    }
}
