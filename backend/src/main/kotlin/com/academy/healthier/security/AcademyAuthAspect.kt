package com.academy.healthier.security

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import org.aspectj.lang.JoinPoint
import org.aspectj.lang.annotation.Aspect
import org.aspectj.lang.annotation.Before
import org.aspectj.lang.reflect.MethodSignature
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Component

@Aspect
@Component
class AcademyAuthAspect(
    private val academyMemberRepository: AcademyMemberRepository
) {

    @Before("@annotation(academyAuth)")
    fun checkAcademyAuth(joinPoint: JoinPoint, academyAuth: AcademyAuth) {
        val principal = SecurityContextHolder.getContext().authentication?.principal as? UserPrincipal
            ?: throw BusinessException(ErrorCode.UNAUTHORIZED)

        // SYSTEM_ADMIN은 모든 학원 접근 가능
        if (principal.systemAdmin) return

        val academyId = extractAcademyId(joinPoint)
            ?: throw BusinessException(ErrorCode.INVALID_INPUT)

        val member = academyMemberRepository.findByAcademyIdAndUserId(academyId, principal.userId)
            ?: throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)

        if (academyAuth.roles.isNotEmpty() && member.role !in academyAuth.roles) {
            throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        }
    }

    private fun extractAcademyId(joinPoint: JoinPoint): Long? {
        val signature = joinPoint.signature as MethodSignature
        val paramNames = signature.parameterNames
        val args = joinPoint.args

        val index = paramNames.indexOfFirst { it == "academyId" || it == "id" }
        if (index >= 0) {
            return args[index] as? Long
        }
        return null
    }
}
