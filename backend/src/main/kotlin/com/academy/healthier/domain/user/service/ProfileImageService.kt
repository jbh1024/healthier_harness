package com.academy.healthier.domain.user.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.domain.user.repository.UserRepository
import com.academy.healthier.infra.file.FileStorageService
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.multipart.MultipartFile

@Service
@Transactional
class ProfileImageService(
    private val userRepository: UserRepository,
    private val fileStorageService: FileStorageService
) {

    companion object {
        private const val PROFILE_DIR = "profiles"
        private val ALLOWED_TYPES = setOf("image/jpeg", "image/png")
        private const val MAX_SIZE = 5L * 1024 * 1024 // 5MB
    }

    fun uploadProfileImage(userId: Long, file: MultipartFile): String {
        validateFile(file)

        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        // 기존 이미지 삭제
        user.profileImageUrl?.let { fileStorageService.delete(it) }
        user.thumbnailImageUrl?.let { fileStorageService.delete(it) }

        val stored = fileStorageService.store(file, PROFILE_DIR)

        user.profileImageUrl = stored.filePath
        user.thumbnailImageUrl = stored.filePath // 썸네일은 추후 별도 생성

        return stored.filePath
    }

    fun deleteProfileImage(userId: Long) {
        val user = userRepository.findById(userId)
            .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }

        user.profileImageUrl?.let { fileStorageService.delete(it) }
        user.thumbnailImageUrl?.let { fileStorageService.delete(it) }

        user.profileImageUrl = null
        user.thumbnailImageUrl = null
    }

    private fun validateFile(file: MultipartFile) {
        if (file.contentType !in ALLOWED_TYPES) {
            throw BusinessException(ErrorCode.INVALID_INPUT)
        }
        if (file.size > MAX_SIZE) {
            throw BusinessException(ErrorCode.INVALID_INPUT)
        }
    }
}
