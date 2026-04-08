package com.academy.healthier.domain.auth.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.auth.dto.TokenResponse
import com.academy.healthier.domain.auth.entity.RefreshToken
import com.academy.healthier.domain.auth.repository.RefreshTokenRepository
import com.academy.healthier.domain.user.repository.UserRepository
import com.academy.healthier.security.jwt.JwtTokenProvider
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@Service
@Transactional(readOnly = true)
class GoogleOAuthService(
    private val userRepository: UserRepository,
    private val refreshTokenRepository: RefreshTokenRepository,
    private val jwtTokenProvider: JwtTokenProvider
) {
    private val log = LoggerFactory.getLogger(javaClass)

    @Transactional
    fun loginWithGoogle(idToken: String): TokenResponse {
        val googleUserInfo = verifyGoogleIdToken(idToken)

        val user = userRepository.findByGoogleId(googleUserInfo.googleId)
            ?: throw BusinessException(ErrorCode.INVALID_CREDENTIALS)

        return generateTokenPair(user.id, user.email)
    }

    @Transactional
    fun linkGoogleAccount(userId: Long, idToken: String) {
        val googleUserInfo = verifyGoogleIdToken(idToken)

        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        val existing = userRepository.findByGoogleId(googleUserInfo.googleId)
        if (existing != null && existing.id != userId) {
            throw BusinessException(ErrorCode.INVALID_INPUT)
        }

        user.googleId = googleUserInfo.googleId
    }

    @Transactional
    fun unlinkGoogleAccount(userId: Long) {
        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }
        user.googleId = null
    }

    private fun verifyGoogleIdToken(idToken: String): GoogleUserInfo {
        // TODO: 실제 Google ID Token 검증 (Google API Client Library)
        // 현재는 토큰을 googleId로 사용하는 stub 구현
        log.warn("Google ID Token 검증 stub: 실제 구현 필요")
        return GoogleUserInfo(
            googleId = idToken,
            email = "",
            name = ""
        )
    }

    private fun generateTokenPair(userId: Long, email: String): TokenResponse {
        val accessToken = jwtTokenProvider.generateAccessToken(userId, email)
        val refreshTokenStr = jwtTokenProvider.generateRefreshToken(userId)

        val user = userRepository.findById(userId).orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }
        val expiresAt = LocalDateTime.now().plusSeconds(jwtTokenProvider.getRefreshTokenExpiryMs() / 1000)

        refreshTokenRepository.save(RefreshToken(user = user, token = refreshTokenStr, expiresAt = expiresAt))

        return TokenResponse(accessToken = accessToken, refreshToken = refreshTokenStr)
    }

    private data class GoogleUserInfo(
        val googleId: String,
        val email: String,
        val name: String
    )
}
