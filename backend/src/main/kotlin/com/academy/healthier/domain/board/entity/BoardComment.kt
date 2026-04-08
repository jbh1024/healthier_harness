package com.academy.healthier.domain.board.entity

import com.academy.healthier.common.entity.BaseEntity
import com.academy.healthier.domain.membership.entity.AcademyMember
import jakarta.persistence.Column
import jakarta.persistence.Entity
import jakarta.persistence.FetchType
import jakarta.persistence.JoinColumn
import jakarta.persistence.ManyToOne
import jakarta.persistence.Table

@Entity
@Table(name = "board_comments")
class BoardComment(
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id", nullable = false)
    val post: BoardPost,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "author_id", nullable = false)
    val author: AcademyMember,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    val parent: BoardComment? = null,

    @Column(nullable = false, columnDefinition = "TEXT")
    var content: String
) : BaseEntity()
