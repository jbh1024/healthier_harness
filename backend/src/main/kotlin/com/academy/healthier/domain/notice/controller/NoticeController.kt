package com.academy.healthier.domain.notice.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.notice.dto.CreateNoticeRequest
import com.academy.healthier.domain.notice.dto.NoticeDetailResponse
import com.academy.healthier.domain.notice.dto.NoticeResponse
import com.academy.healthier.domain.notice.service.NoticeService
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
@RequestMapping("/academies/{academyId}/notices")
class NoticeController(
    private val noticeService: NoticeService
) {

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN])
    fun createNotice(
        @PathVariable academyId: Long,
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: CreateNoticeRequest
    ): ApiResponse<NoticeResponse> {
        return ApiResponse.ok(noticeService.createNotice(academyId, user.userId, request))
    }

    @GetMapping
    @AcademyAuth
    fun getNotices(
        @PathVariable academyId: Long,
        @PageableDefault(size = 20) pageable: Pageable
    ): ApiResponse<PageResponse<NoticeResponse>> {
        return ApiResponse.ok(noticeService.getNotices(academyId, pageable))
    }

    @GetMapping("/{noticeId}")
    @AcademyAuth
    fun getNoticeDetail(
        @PathVariable academyId: Long,
        @PathVariable noticeId: Long,
        @CurrentUser user: UserPrincipal
    ): ApiResponse<NoticeDetailResponse> {
        return ApiResponse.ok(noticeService.getNoticeDetail(noticeId, user.userId))
    }
}
