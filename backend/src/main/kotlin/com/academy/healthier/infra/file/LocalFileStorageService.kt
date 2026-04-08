package com.academy.healthier.infra.file

import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.util.UUID

@Service
class LocalFileStorageService(
    private val properties: FileStorageProperties
) : FileStorageService {

    override fun store(file: MultipartFile, directory: String): StoredFile {
        val uploadPath = Paths.get(properties.uploadDir, directory)
        Files.createDirectories(uploadPath)

        val originalFilename = file.originalFilename ?: "unknown"
        val extension = originalFilename.substringAfterLast('.', "")
        val storedFilename = "${UUID.randomUUID()}.$extension"
        val filePath = uploadPath.resolve(storedFilename)

        file.transferTo(filePath.toFile())

        return StoredFile(
            originalFilename = originalFilename,
            storedFilename = storedFilename,
            filePath = filePath.toString(),
            fileSize = file.size,
            contentType = file.contentType ?: "application/octet-stream"
        )
    }

    override fun delete(filePath: String) {
        val path = Path.of(filePath)
        Files.deleteIfExists(path)
    }

    override fun getFilePath(storedFilename: String, directory: String): String {
        return Paths.get(properties.uploadDir, directory, storedFilename).toString()
    }
}
