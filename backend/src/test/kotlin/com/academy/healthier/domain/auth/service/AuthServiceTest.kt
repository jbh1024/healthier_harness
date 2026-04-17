package com.academy.healthier.domain.auth.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.auth.dto.LoginRequest
import com.academy.healthier.domain.auth.dto.SignupRequest
import com.academy.healthier.domain.auth.entity.PasswordResetToken
import com.academy.healthier.domain.auth.entity.RefreshToken
import com.academy.healthier.domain.auth.repository.PasswordResetTokenRepository
import com.academy.healthier.domain.auth.repository.RefreshTokenRepository
import com.academy.healthier.domain.user.entity.User
import com.academy.healthier.domain.user.repository.UserRepository
import com.academy.healthier.infra.messaging.EmailService
import com.academy.healthier.security.jwt.JwtTokenProvider
import org.assertj.core.api.Assertions.assertThat
import org.assertj.core.api.Assertions.assertThatThrownBy
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.junit.jupiter.MockitoExtension
import org.mockito.kotlin.any
import org.mockito.kotlin.never
import org.mockito.kotlin.verify
import org.mockito.kotlin.whenever
import org.springframework.security.crypto.password.PasswordEncoder
import java.time.LocalDateTime

@ExtendWith(MockitoExtension::class)
class AuthServiceTest {

    @Mock
    private lateinit var userRepository: UserRepository

    @Mock
    private lateinit var refreshTokenRepository: RefreshTokenRepository

    @Mock
    private lateinit var passwordResetTokenRepository: PasswordResetTokenRepository

    @Mock
    private lateinit var jwtTokenProvider: JwtTokenProvider

    @Mock
    private lateinit var passwordEncoder: PasswordEncoder

    @Mock
    private lateinit var emailService: EmailService

    @InjectMocks
    private lateinit var authService: AuthService

    private val validEmail = "user@test.com"
    private val validPassword = "Test1234!"

    private fun stubTokenIssuance() {
        whenever(jwtTokenProvider.generateAccessToken(any(), any())).thenReturn("access-token")
        whenever(jwtTokenProvider.generateRefreshToken(any())).thenReturn("refresh-token")
        whenever(jwtTokenProvider.getRefreshTokenExpiryMs()).thenReturn(14L * 24 * 60 * 60 * 1000)
        whenever(refreshTokenRepository.save(any<RefreshToken>())).thenAnswer { it.arguments[0] }
    }

    @Test
    fun `유효한 정보로 회원가입 시 토큰 발급`() {
        stubTokenIssuance()
        val request = SignupRequest(email = validEmail, password = validPassword, name = "홍길동")
        whenever(userRepository.existsByEmail(validEmail)).thenReturn(false)
        whenever(passwordEncoder.encode(validPassword)).thenReturn("hashed")
        whenever(userRepository.save(any<User>())).thenAnswer { it.arguments[0] }

        val response = authService.signup(request)

        assertThat(response.accessToken).isEqualTo("access-token")
        assertThat(response.refreshToken).isEqualTo("refresh-token")
    }

    @Test
    fun `중복 이메일로 회원가입 시 DUPLICATE_EMAIL 예외 발생`() {
        val request = SignupRequest(email = validEmail, password = validPassword, name = "홍길동")
        whenever(userRepository.existsByEmail(validEmail)).thenReturn(true)

        assertThatThrownBy { authService.signup(request) }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.DUPLICATE_EMAIL)

        verify(userRepository, never()).save(any<User>())
    }

    @Test
    fun `비밀번호 규칙 위반 시 INVALID_PASSWORD_FORMAT 예외 발생`() {
        val weakPasswords = listOf(
            "short1!",       // 8자 미만
            "nouppercase1",  // 특수문자 없음
            "NoSpecial12",   // 특수문자 없음
            "nodigits!!",    // 숫자 없음
            "12345678!"      // 영문 없음
        )

        weakPasswords.forEach { pw ->
            val request = SignupRequest(email = "a@b.com", password = pw, name = "홍길동")
            assertThatThrownBy { authService.signup(request) }
                .isInstanceOf(BusinessException::class.java)
                .extracting("errorCode")
                .isEqualTo(ErrorCode.INVALID_PASSWORD_FORMAT)
        }
    }

    @Test
    fun `존재하지 않는 이메일로 로그인 시 INVALID_CREDENTIALS 예외 발생`() {
        whenever(userRepository.findByEmail(validEmail)).thenReturn(null)

        assertThatThrownBy {
            authService.login(LoginRequest(email = validEmail, password = validPassword))
        }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.INVALID_CREDENTIALS)
    }

    @Test
    fun `비밀번호 불일치 시 INVALID_CREDENTIALS 예외 발생`() {
        val user = User(email = validEmail, passwordHash = "hashed", name = "홍길동")
        whenever(userRepository.findByEmail(validEmail)).thenReturn(user)
        whenever(passwordEncoder.matches(validPassword, "hashed")).thenReturn(false)

        assertThatThrownBy {
            authService.login(LoginRequest(email = validEmail, password = validPassword))
        }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.INVALID_CREDENTIALS)
    }

    @Test
    fun `유효한 자격 증명으로 로그인 시 토큰 발급`() {
        stubTokenIssuance()
        val user = User(email = validEmail, passwordHash = "hashed", name = "홍길동")
        whenever(userRepository.findByEmail(validEmail)).thenReturn(user)
        whenever(passwordEncoder.matches(validPassword, "hashed")).thenReturn(true)

        val response = authService.login(LoginRequest(email = validEmail, password = validPassword))

        assertThat(response.accessToken).isEqualTo("access-token")
        assertThat(response.refreshToken).isEqualTo("refresh-token")
    }

    @Test
    fun `비밀번호 재설정 요청 시 토큰 저장 후 이메일 발송`() {
        val user = User(email = validEmail, passwordHash = "hashed", name = "홍길동")
        whenever(userRepository.findByEmail(validEmail)).thenReturn(user)
        whenever(passwordResetTokenRepository.save(any<PasswordResetToken>()))
            .thenAnswer { it.arguments[0] }

        authService.requestPasswordReset(validEmail)

        verify(passwordResetTokenRepository).deleteByUserId(user.id)
        verify(passwordResetTokenRepository).save(any<PasswordResetToken>())
        verify(emailService).send(
            org.mockito.kotlin.eq(validEmail),
            org.mockito.kotlin.any(),
            org.mockito.kotlin.any()
        )
    }

    @Test
    fun `존재하지 않는 이메일로 재설정 요청 시 조용히 종료`() {
        whenever(userRepository.findByEmail(validEmail)).thenReturn(null)

        authService.requestPasswordReset(validEmail)

        verify(passwordResetTokenRepository, never()).save(any<PasswordResetToken>())
        verify(emailService, never()).send(any(), any(), any())
    }

    @Test
    fun `유효한 토큰과 비밀번호로 재설정 시 비밀번호 변경`() {
        val user = User(email = validEmail, passwordHash = "old-hash", name = "홍길동")
        val token = PasswordResetToken(
            user = user,
            token = "valid-token",
            expiresAt = LocalDateTime.now().plusMinutes(10)
        )
        whenever(passwordResetTokenRepository.findByToken("valid-token")).thenReturn(token)
        whenever(passwordEncoder.encode(validPassword)).thenReturn("new-hash")

        authService.resetPassword("valid-token", validPassword)

        assertThat(user.passwordHash).isEqualTo("new-hash")
        assertThat(token.isUsed()).isTrue
        verify(refreshTokenRepository).deleteByUserId(user.id)
    }

    @Test
    fun `존재하지 않는 토큰으로 재설정 시 INVALID_RESET_TOKEN 예외 발생`() {
        whenever(passwordResetTokenRepository.findByToken("nope")).thenReturn(null)

        assertThatThrownBy { authService.resetPassword("nope", validPassword) }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.INVALID_RESET_TOKEN)
    }

    @Test
    fun `만료된 토큰으로 재설정 시 RESET_TOKEN_EXPIRED 예외 발생`() {
        val user = User(email = validEmail, passwordHash = "hashed", name = "홍길동")
        val expired = PasswordResetToken(
            user = user,
            token = "old-token",
            expiresAt = LocalDateTime.now().minusMinutes(1)
        )
        whenever(passwordResetTokenRepository.findByToken("old-token")).thenReturn(expired)

        assertThatThrownBy { authService.resetPassword("old-token", validPassword) }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.RESET_TOKEN_EXPIRED)
    }

    @Test
    fun `이미 사용된 토큰으로 재설정 시 RESET_TOKEN_ALREADY_USED 예외 발생`() {
        val user = User(email = validEmail, passwordHash = "hashed", name = "홍길동")
        val used = PasswordResetToken(
            user = user,
            token = "used-token",
            expiresAt = LocalDateTime.now().plusMinutes(10),
            usedAt = LocalDateTime.now().minusMinutes(1)
        )
        whenever(passwordResetTokenRepository.findByToken("used-token")).thenReturn(used)

        assertThatThrownBy { authService.resetPassword("used-token", validPassword) }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.RESET_TOKEN_ALREADY_USED)
    }
}
