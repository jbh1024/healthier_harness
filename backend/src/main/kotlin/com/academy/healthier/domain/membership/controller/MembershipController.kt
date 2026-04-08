package com.academy.healthier.domain.membership.controller

import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.membership.dto.MemberResponse
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.membership.service.MembershipService
import com.academy.healthier.security.AcademyAuth
import org.springframework.data.domain.Pageable
import org.springframework.data.web.PageableDefault
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/academies/{academyId}/members")
class MembershipController(
    private val membershipService: MembershipService
) {

    @GetMapping
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN])
    fun getMembers(
        @PathVariable academyId: Long,
        @PageableDefault(size = 20) pageable: Pageable
    ): ApiResponse<PageResponse<MemberResponse>> {
        return ApiResponse.ok(membershipService.getMembers(academyId, pageable))
    }
}
