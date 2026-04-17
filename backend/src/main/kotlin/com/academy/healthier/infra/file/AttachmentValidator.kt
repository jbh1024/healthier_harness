package com.academy.healthier.infra.file

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import org.springframework.web.multipart.MultipartFile

object AttachmentValidator {
    private const val MAX_SIZE = 10L * 1024 * 1024 // 10MB

    private val ALLOWED_CONTENT_TYPES = setOf(
        // 이미지
        "image/jpeg",
        "image/png",
        "image/gif",
        // 문서
        "application/pdf",
        "application/msword",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "application/x-hwp",
        "application/haansofthwp",
        "application/vnd.hancom.hwp",
        "application/vnd.ms-excel",
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )

    private val ALLOWED_EXTENSIONS = setOf(
        "jpg", "jpeg", "png", "gif",
        "pdf", "doc", "docx", "hwp", "xls", "xlsx"
    )

    fun validate(file: MultipartFile) {
        if (file.isEmpty) {
            throw BusinessException(ErrorCode.INVALID_ATTACHMENT)
        }
        if (file.size > MAX_SIZE) {
            throw BusinessException(ErrorCode.ATTACHMENT_TOO_LARGE)
        }

        val contentType = file.contentType?.lowercase()
        if (contentType !in ALLOWED_CONTENT_TYPES) {
            throw BusinessException(ErrorCode.UNSUPPORTED_ATTACHMENT_TYPE)
        }

        val extension = file.originalFilename
            ?.substringAfterLast('.', "")
            ?.lowercase()
            ?: ""
        if (extension !in ALLOWED_EXTENSIONS) {
            throw BusinessException(ErrorCode.UNSUPPORTED_ATTACHMENT_TYPE)
        }
    }
}
