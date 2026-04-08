package com.academy.healthier.domain.enrollment.repository

import com.academy.healthier.domain.enrollment.entity.CreditHistory
import org.springframework.data.jpa.repository.JpaRepository

interface CreditHistoryRepository : JpaRepository<CreditHistory, Long> {
    fun findByMemberIdOrderByCreatedAtDesc(memberId: Long): List<CreditHistory>
}
