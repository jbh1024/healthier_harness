package com.academy.healthier.domain.academy.dto

import com.academy.healthier.domain.academy.entity.Academy

data class AcademyResponse(
    val id: Long,
    val name: String,
    val description: String?,
    val contactInfo: String?,
    val isActive: Boolean
) {
    companion object {
        fun from(academy: Academy): AcademyResponse = AcademyResponse(
            id = academy.id,
            name = academy.name,
            description = academy.description,
            contactInfo = academy.contactInfo,
            isActive = academy.isActive
        )
    }
}
