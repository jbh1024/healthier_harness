package com.academy.healthier.infra.file

import org.springframework.web.multipart.MultipartFile

interface FileStorageService {
    fun store(file: MultipartFile, directory: String): StoredFile
    fun delete(filePath: String)
    fun getFilePath(storedFilename: String, directory: String): String
}

data class StoredFile(
    val originalFilename: String,
    val storedFilename: String,
    val filePath: String,
    val fileSize: Long,
    val contentType: String
)
