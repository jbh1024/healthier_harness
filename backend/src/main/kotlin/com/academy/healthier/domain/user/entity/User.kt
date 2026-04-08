package com.academy.healthier.domain.user.entity

import com.academy.healthier.common.entity.BaseEntity
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.Table

@Entity
@Table(name = "users")
class User(
    @Column(nullable = false, unique = true)
    val email: String,

    @Column(name = "password_hash", nullable = false)
    var passwordHash: String,

    @Column(nullable = false, length = 50)
    var name: String,

    @Column(length = 20)
    var phone: String? = null,

    @Column(name = "profile_image_url", length = 500)
    var profileImageUrl: String? = null,

    @Column(name = "thumbnail_image_url", length = 500)
    var thumbnailImageUrl: String? = null,

    @Column(name = "is_system_admin", nullable = false)
    val isSystemAdmin: Boolean = false
) : BaseEntity()
