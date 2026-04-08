package com.academy.healthier.domain.auth.dto

import jakarta.validation.constraints.NotBlank

data class PasskeyRegisterRequest(
    @field:NotBlank(message = "Credential ID는 필수입니다")
    val credentialId: String,

    @field:NotBlank(message = "Public Key는 필수입니다")
    val publicKey: String,

    val deviceName: String? = null
)

data class PasskeyAuthenticateRequest(
    @field:NotBlank(message = "Credential ID는 필수입니다")
    val credentialId: String,

    val signCount: Long = 0
)

data class PasskeyResponse(
    val id: Long,
    val credentialId: String,
    val deviceName: String?,
    val createdAt: String
)
