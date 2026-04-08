package com.academy.healthier.domain.auth.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.auth.dto.LoginRequest
import com.academy.healthier.domain.auth.dto.RefreshRequest
import com.academy.healthier.domain.auth.dto.SignupRequest
import com.academy.healthier.domain.auth.dto.TokenResponse
import com.academy.healthier.domain.auth.entity.RefreshToken
import com.academy.healthier.domain.auth.repository.RefreshTokenRepository
import com.academy.healthier.domain.user.entity.User
import com.academy.healthier.domain.user.repository.UserRepository
import com.academy.healthier.security.jwt.JwtTokenProvider
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@Service
@Transactional(readOnly = true)
class AuthService(
    private val userRepository: UserRepository,
    private val refreshTokenRepository: RefreshTokenRepository,
    private val jwtTokenProvider: JwtTokenProvider,
    private val passwordEncoder: PasswordEncoder
) {

    @Transactional
    fun signup(request: SignupRequest): TokenResponse {
        validatePasswordFormat(request.password)

        if (userRepository.existsByEmail(request.email)) {
            throw BusinessException(ErrorCode.DUPLICATE_EMAIL)
        }

        val user = userRepository.save(
            User(
                email = request.email,
                passwordHash = passwordEncoder.encode(request.password),
                name = request.name,
                phone = request.phone
            )
        )

        return generateTokenPair(user)
    }

    @Transactional
    fun login(request: LoginRequest): TokenResponse {
        val user = userRepository.findByEmail(request.email)
            ?: throw BusinessException(ErrorCode.INVALID_CREDENTIALS)

        if (!passwordEncoder.matches(request.password, user.passwordHash)) {
            throw BusinessException(ErrorCode.INVALID_CREDENTIALS)
        }

        return generateTokenPair(user)
    }

    @Transactional
    fun refresh(request: RefreshRequest): TokenResponse {
        val storedToken = refreshTokenRepository.findByToken(request.refreshToken)
            ?: throw BusinessException(ErrorCode.INVALID_REFRESH_TOKEN)

        if (storedToken.isExpired()) {
            refreshTokenRepository.delete(storedToken)
            throw BusinessException(ErrorCode.EXPIRED_TOKEN)
        }

        // sliding window: 기존 토큰 삭제 후 새 토큰 발급
        refreshTokenRepository.delete(storedToken)
        return generateTokenPair(storedToken.user)
    }

    @Transactional
    fun logout(userId: Long) {
        refreshTokenRepository.deleteByUserId(userId)
    }

    @Transactional
    fun changePassword(userId: Long, currentPassword: String, newPassword: String) {
        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        if (!passwordEncoder.matches(currentPassword, user.passwordHash)) {
            throw BusinessException(ErrorCode.INVALID_CREDENTIALS)
        }

        validatePasswordFormat(newPassword)
        user.passwordHash = passwordEncoder.encode(newPassword)
    }

    private fun generateTokenPair(user: User): TokenResponse {
        val accessToken = jwtTokenProvider.generateAccessToken(user.id, user.email)
        val refreshTokenStr = jwtTokenProvider.generateRefreshToken(user.id)

        val expiresAt = LocalDateTime.now().plusSeconds(
            jwtTokenProvider.getRefreshTokenExpiryMs() / 1000
        )

        refreshTokenRepository.save(
            RefreshToken(
                user = user,
                token = refreshTokenStr,
                expiresAt = expiresAt
            )
        )

        return TokenResponse(
            accessToken = accessToken,
            refreshToken = refreshTokenStr
        )
    }

    private fun validatePasswordFormat(password: String) {
        val regex = Regex("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#\$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]).{8,}$")
        if (!regex.matches(password)) {
            throw BusinessException(ErrorCode.INVALID_PASSWORD_FORMAT)
        }
    }
}
