package com.academy.healthier.domain.auth.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.domain.auth.dto.ChangePasswordRequest
import com.academy.healthier.domain.auth.dto.ForgotPasswordRequest
import com.academy.healthier.domain.auth.dto.GoogleLoginRequest
import com.academy.healthier.domain.auth.dto.JoinAcademyRequest
import com.academy.healthier.domain.auth.dto.LoginRequest
import com.academy.healthier.domain.auth.dto.RefreshRequest
import com.academy.healthier.domain.auth.dto.ResetPasswordRequest
import com.academy.healthier.domain.auth.dto.SignupRequest
import com.academy.healthier.domain.auth.dto.TokenResponse
import com.academy.healthier.domain.auth.service.AuthService
import com.academy.healthier.domain.auth.dto.PasskeyAuthenticateRequest
import com.academy.healthier.domain.auth.dto.PasskeyRegisterRequest
import com.academy.healthier.domain.auth.dto.PasskeyResponse
import com.academy.healthier.domain.auth.service.GoogleOAuthService
import com.academy.healthier.domain.auth.service.PasskeyService
import com.academy.healthier.domain.invite.service.InviteCodeService
import com.academy.healthier.security.UserPrincipal
import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/auth")
class AuthController(
    private val authService: AuthService,
    private val inviteCodeService: InviteCodeService,
    private val googleOAuthService: GoogleOAuthService,
    private val passkeyService: PasskeyService
) {

    @PostMapping("/signup")
    @ResponseStatus(HttpStatus.CREATED)
    fun signup(@Valid @RequestBody request: SignupRequest): ApiResponse<TokenResponse> {
        return ApiResponse.ok(authService.signup(request))
    }

    @PostMapping("/login")
    fun login(@Valid @RequestBody request: LoginRequest): ApiResponse<TokenResponse> {
        return ApiResponse.ok(authService.login(request))
    }

    @PostMapping("/refresh")
    fun refresh(@Valid @RequestBody request: RefreshRequest): ApiResponse<TokenResponse> {
        return ApiResponse.ok(authService.refresh(request))
    }

    @PostMapping("/logout")
    fun logout(@CurrentUser user: UserPrincipal): ApiResponse<Unit> {
        authService.logout(user.userId)
        return ApiResponse.ok()
    }

    @PostMapping("/join-academy")
    fun joinAcademy(
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: JoinAcademyRequest
    ): ApiResponse<Unit> {
        inviteCodeService.joinAcademy(user.userId, request.inviteCode)
        return ApiResponse.ok()
    }

    @PostMapping("/forgot-password")
    fun forgotPassword(@Valid @RequestBody request: ForgotPasswordRequest): ApiResponse<Unit> {
        authService.requestPasswordReset(request.email)
        return ApiResponse.ok()
    }

    @PostMapping("/reset-password")
    fun resetPassword(@Valid @RequestBody request: ResetPasswordRequest): ApiResponse<Unit> {
        authService.resetPassword(request.token, request.newPassword)
        return ApiResponse.ok()
    }

    @PutMapping("/password")
    fun changePassword(
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: ChangePasswordRequest
    ): ApiResponse<Unit> {
        authService.changePassword(user.userId, request.currentPassword, request.newPassword)
        return ApiResponse.ok()
    }

    @PostMapping("/google")
    fun googleLogin(@Valid @RequestBody request: GoogleLoginRequest): ApiResponse<TokenResponse> {
        return ApiResponse.ok(googleOAuthService.loginWithGoogle(request.idToken))
    }

    @PostMapping("/google/link")
    fun linkGoogle(
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: GoogleLoginRequest
    ): ApiResponse<Unit> {
        googleOAuthService.linkGoogleAccount(user.userId, request.idToken)
        return ApiResponse.ok()
    }

    @DeleteMapping("/google/link")
    fun unlinkGoogle(@CurrentUser user: UserPrincipal): ApiResponse<Unit> {
        googleOAuthService.unlinkGoogleAccount(user.userId)
        return ApiResponse.ok()
    }

    @PostMapping("/passkey/register")
    @ResponseStatus(HttpStatus.CREATED)
    fun registerPasskey(
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: PasskeyRegisterRequest
    ): ApiResponse<PasskeyResponse> {
        return ApiResponse.ok(passkeyService.register(user.userId, request))
    }

    @PostMapping("/passkey/authenticate")
    fun authenticatePasskey(
        @Valid @RequestBody request: PasskeyAuthenticateRequest
    ): ApiResponse<TokenResponse> {
        return ApiResponse.ok(passkeyService.authenticate(request))
    }

    @DeleteMapping("/passkey/{passkeyId}")
    fun deletePasskey(
        @CurrentUser user: UserPrincipal,
        @PathVariable passkeyId: Long
    ): ApiResponse<Unit> {
        passkeyService.deletePasskey(passkeyId, user.userId)
        return ApiResponse.ok()
    }
}
