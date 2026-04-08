package com.academy.healthier.domain.user.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.domain.user.dto.UpdateProfileRequest
import com.academy.healthier.domain.user.dto.UserResponse
import com.academy.healthier.domain.user.service.ProfileImageService
import com.academy.healthier.domain.user.service.UserService
import com.academy.healthier.security.UserPrincipal
import org.springframework.http.HttpStatus
import jakarta.validation.Valid
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.multipart.MultipartFile

@RestController
@RequestMapping("/users")
class UserController(
    private val userService: UserService,
    private val profileImageService: ProfileImageService
) {

    @GetMapping("/me")
    fun getMyProfile(@CurrentUser user: UserPrincipal): ApiResponse<UserResponse> {
        return ApiResponse.ok(userService.getMyProfile(user.userId))
    }

    @PutMapping("/me")
    fun updateProfile(
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: UpdateProfileRequest
    ): ApiResponse<UserResponse> {
        return ApiResponse.ok(userService.updateProfile(user.userId, request))
    }

    @PostMapping("/me/profile-image")
    @ResponseStatus(HttpStatus.CREATED)
    fun uploadProfileImage(
        @CurrentUser user: UserPrincipal,
        @RequestParam("file") file: MultipartFile
    ): ApiResponse<Map<String, String>> {
        val path = profileImageService.uploadProfileImage(user.userId, file)
        return ApiResponse.ok(mapOf("profileImageUrl" to path))
    }

    @DeleteMapping("/me/profile-image")
    fun deleteProfileImage(@CurrentUser user: UserPrincipal): ApiResponse<Unit> {
        profileImageService.deleteProfileImage(user.userId)
        return ApiResponse.ok()
    }
}
