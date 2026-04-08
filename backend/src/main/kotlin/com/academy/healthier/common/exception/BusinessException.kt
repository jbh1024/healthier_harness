package com.academy.healthier.common.exception

class BusinessException(
    val errorCode: ErrorCode
) : RuntimeException(errorCode.message)
