package com.academy.healthier.domain.auth.repository

import com.academy.healthier.domain.auth.entity.RefreshToken
import org.springframework.data.jpa.repository.JpaRepository

interface RefreshTokenRepository : JpaRepository<RefreshToken, Long> {
    fun findByToken(token: String): RefreshToken?
    fun deleteByUserId(userId: Long)
    fun deleteByToken(token: String)
}
