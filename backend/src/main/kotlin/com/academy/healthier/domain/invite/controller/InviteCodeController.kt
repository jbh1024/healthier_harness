package com.academy.healthier.domain.invite.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.invite.dto.CreateInviteCodeRequest
import com.academy.healthier.domain.invite.dto.InviteCodeResponse
import com.academy.healthier.domain.invite.service.InviteCodeService
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.security.AcademyAuth
import com.academy.healthier.security.UserPrincipal
import jakarta.validation.Valid
import org.springframework.data.domain.Pageable
import org.springframework.data.web.PageableDefault
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/academies/{academyId}/invite-codes")
class InviteCodeController(
    private val inviteCodeService: InviteCodeService
) {

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN])
    fun createInviteCode(
        @PathVariable academyId: Long,
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: CreateInviteCodeRequest
    ): ApiResponse<InviteCodeResponse> {
        return ApiResponse.ok(inviteCodeService.createInviteCode(academyId, user.userId, request))
    }

    @GetMapping
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN])
    fun getInviteCodes(
        @PathVariable academyId: Long,
        @PageableDefault(size = 20) pageable: Pageable
    ): ApiResponse<PageResponse<InviteCodeResponse>> {
        return ApiResponse.ok(inviteCodeService.getInviteCodes(academyId, pageable))
    }
}
