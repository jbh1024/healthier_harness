package com.academy.healthier.domain.notice.entity

import com.academy.healthier.common.entity.BaseEntity
import com.academy.healthier.domain.academy.entity.Academy
import com.academy.healthier.domain.membership.entity.AcademyMember
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.FetchType
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table

@Entity
@Table(name = "notices")
class Notice(
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "academy_id", nullable = false)
    val academy: Academy,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "author_id", nullable = false)
    val author: AcademyMember,

    @Column(nullable = false, length = 200)
    var title: String,

    @Column(nullable = false, columnDefinition = "TEXT")
    var content: String,

    @Column(name = "is_important", nullable = false)
    var isImportant: Boolean = false,

    @Column(name = "view_count", nullable = false)
    var viewCount: Int = 0
) : BaseEntity()
