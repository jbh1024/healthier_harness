package com.academy.healthier.domain.invite.entity

import com.academy.healthier.domain.academy.entity.Academy
import com.academy.healthier.domain.membership.entity.MemberRole
import com.academy.healthier.domain.user.entity.User
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import java.time.LocalDateTime

class InviteCodeTest {

    private fun sampleCode(
        maxUses: Int? = null,
        unlimited: Boolean = false,
        expiresAt: LocalDateTime? = null,
        isActive: Boolean = true,
        currentUses: Int = 0
    ): InviteCode {
        val academy = Academy(name = "테스트학원")
        val user = User(email = "admin@test.com", passwordHash = "hash", name = "관리자")
        return InviteCode(
            academy = academy,
            code = "ABC123",
            role = MemberRole.STUDENT,
            grantedCredits = 10,
            maxUses = maxUses,
            currentUses = currentUses,
            unlimited = unlimited,
            expiresAt = expiresAt,
            isActive = isActive,
            createdBy = user
        )
    }

    @Test
    fun `활성 상태의 신규 초대코드는 사용 가능`() {
        val code = sampleCode(maxUses = 5)
        assertThat(code.isUsable()).isTrue
    }

    @Test
    fun `비활성화된 초대코드는 사용 불가`() {
        val code = sampleCode(isActive = false)
        assertThat(code.isUsable()).isFalse
    }

    @Test
    fun `만료된 초대코드는 사용 불가`() {
        val code = sampleCode(expiresAt = LocalDateTime.now().minusDays(1))
        assertThat(code.isUsable()).isFalse
    }

    @Test
    fun `사용 횟수가 최대치에 도달하면 사용 불가`() {
        val code = sampleCode(maxUses = 3, currentUses = 3)
        assertThat(code.isUsable()).isFalse
    }

    @Test
    fun `unlimited true 이면 사용 횟수 제한 무시`() {
        val code = sampleCode(maxUses = 3, currentUses = 100, unlimited = true)
        assertThat(code.isUsable()).isTrue
    }

    @Test
    fun `use 호출 시 currentUses 가 1 증가`() {
        val code = sampleCode(maxUses = 5, currentUses = 2)
        code.use()
        assertThat(code.currentUses).isEqualTo(3)
    }
}
