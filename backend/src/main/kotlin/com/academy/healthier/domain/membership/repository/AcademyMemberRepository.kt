package com.academy.healthier.domain.membership.repository

import com.academy.healthier.domain.membership.entity.AcademyMember
import com.academy.healthier.domain.membership.entity.MemberRole
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface AcademyMemberRepository : JpaRepository<AcademyMember, Long> {

    fun findByAcademyIdAndUserId(academyId: Long, userId: Long): AcademyMember?

    fun existsByAcademyIdAndUserId(academyId: Long, userId: Long): Boolean

    @Query("SELECT m FROM AcademyMember m JOIN FETCH m.user WHERE m.academy.id = :academyId")
    fun findByAcademyIdWithUser(academyId: Long, pageable: Pageable): Page<AcademyMember>

    @Query("SELECT m FROM AcademyMember m JOIN FETCH m.academy WHERE m.user.id = :userId")
    fun findByUserIdWithAcademy(userId: Long): List<AcademyMember>

    fun findByAcademyIdAndRole(academyId: Long, role: MemberRole): List<AcademyMember>
}
