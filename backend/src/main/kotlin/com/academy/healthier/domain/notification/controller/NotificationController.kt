package com.academy.healthier.domain.notification.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.notification.dto.NotificationResponse
import com.academy.healthier.domain.notification.dto.NotificationSettingResponse
import com.academy.healthier.domain.notification.dto.UpdateNotificationSettingRequest
import com.academy.healthier.domain.notification.service.NotificationService
import com.academy.healthier.security.UserPrincipal
import org.springframework.data.domain.Pageable
import org.springframework.data.web.PageableDefault
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping
class NotificationController(
    private val notificationService: NotificationService
) {

    @GetMapping("/notifications")
    fun getNotifications(
        @CurrentUser user: UserPrincipal,
        @PageableDefault(size = 20) pageable: Pageable
    ): ApiResponse<PageResponse<NotificationResponse>> {
        return ApiResponse.ok(notificationService.getNotifications(user.userId, pageable))
    }

    @GetMapping("/notifications/unread-count")
    fun getUnreadCount(@CurrentUser user: UserPrincipal): ApiResponse<Map<String, Long>> {
        return ApiResponse.ok(mapOf("count" to notificationService.getUnreadCount(user.userId)))
    }

    @PutMapping("/notifications/{id}/read")
    fun markAsRead(
        @PathVariable id: Long,
        @CurrentUser user: UserPrincipal
    ): ApiResponse<Unit> {
        notificationService.markAsRead(id, user.userId)
        return ApiResponse.ok()
    }

    @PutMapping("/notifications/read-all")
    fun markAllAsRead(@CurrentUser user: UserPrincipal): ApiResponse<Unit> {
        notificationService.markAllAsRead(user.userId)
        return ApiResponse.ok()
    }

    @GetMapping("/notification-settings")
    fun getSettings(@CurrentUser user: UserPrincipal): ApiResponse<NotificationSettingResponse> {
        return ApiResponse.ok(notificationService.getSettings(user.userId))
    }

    @PutMapping("/notification-settings")
    fun updateSettings(
        @CurrentUser user: UserPrincipal,
        @RequestBody request: UpdateNotificationSettingRequest
    ): ApiResponse<NotificationSettingResponse> {
        return ApiResponse.ok(notificationService.updateSettings(user.userId, request))
    }
}
