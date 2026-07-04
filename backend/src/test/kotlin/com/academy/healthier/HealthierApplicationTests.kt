package com.academy.healthier

import org.junit.jupiter.api.Test
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles

@SpringBootTest
@ActiveProfiles("test")
class HealthierApplicationTests {
    @Test
    fun `컨텍스트 로드 테스트`() {
        // 스프링 컨텍스트 기동만 검증
    }
}
