package com.academy.healthier.infra.file

import org.springframework.boot.context.properties.ConfigurationProperties

@ConfigurationProperties(prefix = "file")
data class FileStorageProperties(
    val uploadDir: String = "./uploads"
)
