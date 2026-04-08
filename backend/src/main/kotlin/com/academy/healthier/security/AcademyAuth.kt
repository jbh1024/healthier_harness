package com.academy.healthier.security

import com.academy.healthier.domain.membership.entity.MemberRole

@Target(AnnotationTarget.FUNCTION)
@Retention(AnnotationRetention.RUNTIME)
annotation class AcademyAuth(
    val roles: Array<MemberRole> = []
)
