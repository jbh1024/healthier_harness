package com.academy.healthier.domain.auth.repository

import com.academy.healthier.domain.auth.entity.PasskeyCredential
import org.springframework.data.jpa.repository.JpaRepository

interface PasskeyCredentialRepository : JpaRepository<PasskeyCredential, Long> {
    fun findByCredentialId(credentialId: String): PasskeyCredential?
    fun findByUserId(userId: Long): List<PasskeyCredential>
    fun deleteByIdAndUserId(id: Long, userId: Long)
}
