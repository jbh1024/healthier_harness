package com.academy.healthier.common.response

import org.springframework.data.domain.Page

data class PageResponse<T>(
    val content: List<T>,
    val totalElements: Long,
    val totalPages: Int,
    val currentPage: Int,
    val hasNext: Boolean
) {
    companion object {
        fun <T> from(page: Page<T>): PageResponse<T> = PageResponse(
            content = page.content,
            totalElements = page.totalElements,
            totalPages = page.totalPages,
            currentPage = page.number,
            hasNext = page.hasNext()
        )

        fun <T, R> from(page: Page<T>, transform: (T) -> R): PageResponse<R> = PageResponse(
            content = page.content.map(transform),
            totalElements = page.totalElements,
            totalPages = page.totalPages,
            currentPage = page.number,
            hasNext = page.hasNext()
        )
    }
}
