package com.academy.healthier.domain.auth.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.auth.dto.PasskeyAuthenticateRequest
import com.academy.healthier.domain.auth.dto.PasskeyRegisterRequest
import com.academy.healthier.domain.auth.dto.PasskeyResponse
import com.academy.healthier.domain.auth.dto.TokenResponse
import com.academy.healthier.domain.auth.entity.PasskeyCredential
import com.academy.healthier.domain.auth.entity.RefreshToken
import com.academy.healthier.domain.auth.repository.PasskeyCredentialRepository
import com.academy.healthier.domain.auth.repository.RefreshTokenRepository
import com.academy.healthier.domain.user.repository.UserRepository
import com.academy.healthier.security.jwt.JwtTokenProvider
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDateTime

@Service
@Transactional(readOnly = true)
class PasskeyService(
    private val passkeyCredentialRepository: PasskeyCredentialRepository,
    private val userRepository: UserRepository,
    private val refreshTokenRepository: RefreshTokenRepository,
    private val jwtTokenProvider: JwtTokenProvider
) {
    private val log = LoggerFactory.getLogger(javaClass)

    @Transactional
    fun register(userId: Long, request: PasskeyRegisterRequest): PasskeyResponse {
        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        // TODO: 실제 WebAuthn 검증 로직 (java-webauthn-server)
        log.warn("Passkey 등록 stub: 실제 WebAuthn 검증 필요")

        val credential = passkeyCredentialRepository.save(
            PasskeyCredential(
                user = user,
                credentialId = request.credentialId,
                publicKey = request.publicKey,
                deviceName = request.deviceName
            )
        )

        return PasskeyResponse(
            id = credential.id,
            credentialId = credential.credentialId,
            deviceName = credential.deviceName,
            createdAt = credential.createdAt.toString()
        )
    }

    @Transactional
    fun authenticate(request: PasskeyAuthenticateRequest): TokenResponse {
        val credential = passkeyCredentialRepository.findByCredentialId(request.credentialId)
            ?: throw BusinessException(ErrorCode.INVALID_CREDENTIALS)

        // TODO: 실제 WebAuthn 서명 검증 (public key로 signature 검증)
        log.warn("Passkey 인증 stub: 실제 WebAuthn 서명 검증 필요")

        credential.signCount = request.signCount
        credential.updatedAt = LocalDateTime.now()

        val user = credential.user
        val accessToken = jwtTokenProvider.generateAccessToken(user.id, user.email)
        val refreshTokenStr = jwtTokenProvider.generateRefreshToken(user.id)
        val expiresAt = LocalDateTime.now().plusSeconds(jwtTokenProvider.getRefreshTokenExpiryMs() / 1000)

        refreshTokenRepository.save(RefreshToken(user = user, token = refreshTokenStr, expiresAt = expiresAt))

        return TokenResponse(accessToken = accessToken, refreshToken = refreshTokenStr)
    }

    fun getMyPasskeys(userId: Long): List<PasskeyResponse> {
        return passkeyCredentialRepository.findByUserId(userId).map {
            PasskeyResponse(
                id = it.id,
                credentialId = it.credentialId,
                deviceName = it.deviceName,
                createdAt = it.createdAt.toString()
            )
        }
    }

    @Transactional
    fun deletePasskey(passkeyId: Long, userId: Long) {
        passkeyCredentialRepository.deleteByIdAndUserId(passkeyId, userId)
    }
}
