package com.academy.healthier.domain.auth.entity

import com.academy.healthier.domain.user.entity.User
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.FetchType
import jakarta.persistence.GeneratedValue
import jakarta.persistence.GenerationType
import jakarta.persistence.Id
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table
import java.time.LocalDateTime

@Entity
@Table(name = "passkey_credentials")
class PasskeyCredential(
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    val user: User,

    @Column(name = "credential_id", nullable = false, unique = true, length = 500)
    val credentialId: String,

    @Column(name = "public_key", nullable = false, columnDefinition = "TEXT")
    val publicKey: String,

    @Column(name = "sign_count", nullable = false)
    var signCount: Long = 0,

    @Column(name = "device_name", length = 100)
    val deviceName: String? = null,

    @Column(name = "created_at", nullable = false, updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now(),

    @Column(name = "updated_at", nullable = false)
    var updatedAt: LocalDateTime = LocalDateTime.now()
) {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0
}
