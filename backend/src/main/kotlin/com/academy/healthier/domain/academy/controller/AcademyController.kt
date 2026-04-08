package com.academy.healthier.domain.academy.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.domain.academy.dto.AcademyResponse
import com.academy.healthier.domain.academy.dto.CreateAcademyRequest
import com.academy.healthier.domain.academy.service.AcademyService
import com.academy.healthier.security.UserPrincipal
import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/academies")
class AcademyController(
    private val academyService: AcademyService
) {

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    fun createAcademy(
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: CreateAcademyRequest
    ): ApiResponse<AcademyResponse> {
        if (!user.systemAdmin) {
            throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        }
        return ApiResponse.ok(academyService.createAcademy(request))
    }

    @GetMapping
    fun getMyAcademies(@CurrentUser user: UserPrincipal): ApiResponse<List<AcademyResponse>> {
        return ApiResponse.ok(academyService.getMyAcademies(user.userId, user.systemAdmin))
    }

    @GetMapping("/{id}")
    fun getAcademyDetail(
        @CurrentUser user: UserPrincipal,
        @PathVariable id: Long
    ): ApiResponse<AcademyResponse> {
        return ApiResponse.ok(academyService.getAcademyDetail(id, user.userId, user.systemAdmin))
    }
}
