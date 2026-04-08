package com.academy.healthier.domain.membership.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.membership.dto.ChargeCreditRequest
import com.academy.healthier.domain.membership.dto.MemberResponse
import com.academy.healthier.domain.membership.dto.UpdateMemberRoleRequest
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.membership.service.MembershipService
import com.academy.healthier.security.AcademyAuth
import com.academy.healthier.security.UserPrincipal
import jakarta.validation.Valid
import org.springframework.data.domain.Pageable
import org.springframework.data.web.PageableDefault
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
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

    @PutMapping("/{memberId}/role")
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN])
    fun updateMemberRole(
        @PathVariable academyId: Long,
        @PathVariable memberId: Long,
        @Valid @RequestBody request: UpdateMemberRoleRequest
    ): ApiResponse<Unit> {
        membershipService.updateMemberRole(academyId, memberId, request.role)
        return ApiResponse.ok()
    }

    @DeleteMapping("/{memberId}")
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN])
    fun removeMember(
        @PathVariable academyId: Long,
        @PathVariable memberId: Long,
        @CurrentUser user: UserPrincipal
    ): ApiResponse<Unit> {
        membershipService.removeMember(academyId, memberId, user.userId)
        return ApiResponse.ok()
    }

    @PutMapping("/{memberId}/credits")
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN])
    fun chargeCredits(
        @PathVariable academyId: Long,
        @PathVariable memberId: Long,
        @Valid @RequestBody request: ChargeCreditRequest
    ): ApiResponse<Unit> {
        membershipService.chargeCredits(academyId, memberId, request.amount)
        return ApiResponse.ok()
    }
}
