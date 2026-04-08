package com.academy.healthier.domain.academy.controller

import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.domain.academy.dto.DashboardResponse
import com.academy.healthier.domain.academy.service.DashboardService
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.security.AcademyAuth
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/academies/{academyId}/dashboard")
class DashboardController(
    private val dashboardService: DashboardService
) {

    @GetMapping
    @AcademyAuth(roles = [MemberRole.ACADEMY_ADMIN])
    fun getDashboard(@PathVariable academyId: Long): ApiResponse<DashboardResponse> {
        return ApiResponse.ok(dashboardService.getDashboard(academyId))
    }
}
