package com.academy.healthier.domain.invite.repository

import com.academy.healthier.domain.invite.entity.InviteCode
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository

interface InviteCodeRepository : JpaRepository<InviteCode, Long> {
    fun findByCode(code: String): InviteCode?
    fun findByAcademyId(academyId: Long, pageable: Pageable): Page<InviteCode>
}
