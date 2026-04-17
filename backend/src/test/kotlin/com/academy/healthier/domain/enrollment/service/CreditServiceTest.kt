package com.academy.healthier.domain.enrollment.service

import com.academy.healthier.domain.academy.entity.Academy
import com.academy.healthier.domain.enrollment.entity.CreditHistory
import com.academy.healthier.domain.enrollment.entity.CreditReason
import com.academy.healthier.domain.enrollment.repository.CreditHistoryRepository
import com.academy.healthier.domain.membership.entity.AcademyMember
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.user.entity.User
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.junit.jupiter.MockitoExtension
import org.mockito.kotlin.any
import org.mockito.kotlin.argumentCaptor
import org.mockito.kotlin.verify
import org.mockito.kotlin.whenever

@ExtendWith(MockitoExtension::class)
class CreditServiceTest {

    @Mock
    private lateinit var creditHistoryRepository: CreditHistoryRepository

    @InjectMocks
    private lateinit var creditService: CreditService

    private lateinit var member: AcademyMember

    @BeforeEach
    fun setUp() {
        val academy = Academy(name = "테스트학원")
        val user = User(email = "student@test.com", passwordHash = "hash", name = "학생")
        member = AcademyMember(
            academy = academy,
            user = user,
            role = MemberRole.STUDENT,
            remainingCredits = 5
        )
        whenever(creditHistoryRepository.save(any<CreditHistory>())).thenAnswer { it.arguments[0] }
    }

    @Test
    fun `deduct 호출 시 잔여 횟수가 1 감소`() {
        creditService.deduct(member, referenceId = 100L)

        assertThat(member.remainingCredits).isEqualTo(4)
    }

    @Test
    fun `deduct 호출 시 ENROLLMENT 사유로 이력 저장`() {
        creditService.deduct(member, referenceId = 100L)

        val captor = argumentCaptor<CreditHistory>()
        verify(creditHistoryRepository).save(captor.capture())
        val history = captor.firstValue
        assertThat(history.changeAmount).isEqualTo(-1)
        assertThat(history.reason).isEqualTo(CreditReason.ENROLLMENT)
        assertThat(history.referenceId).isEqualTo(100L)
    }

    @Test
    fun `restore 호출 시 잔여 횟수가 1 증가`() {
        creditService.restore(member, referenceId = 200L)

        assertThat(member.remainingCredits).isEqualTo(6)
    }

    @Test
    fun `restore 호출 시 CANCELLATION 사유로 이력 저장`() {
        creditService.restore(member, referenceId = 200L)

        val captor = argumentCaptor<CreditHistory>()
        verify(creditHistoryRepository).save(captor.capture())
        val history = captor.firstValue
        assertThat(history.changeAmount).isEqualTo(1)
        assertThat(history.reason).isEqualTo(CreditReason.CANCELLATION)
        assertThat(history.referenceId).isEqualTo(200L)
    }
}
