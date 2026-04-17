package com.academy.healthier.domain.notice.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.academy.repository.AcademyRepository
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import com.academy.healthier.domain.notice.dto.CreateNoticeRequest
import com.academy.healthier.domain.notice.dto.NoticeDetailResponse
import com.academy.healthier.domain.notice.dto.NoticeResponse
import com.academy.healthier.domain.notice.dto.UpdateNoticeRequest
import com.academy.healthier.domain.notice.entity.Notice
import com.academy.healthier.domain.notice.entity.NoticeView
import com.academy.healthier.domain.notice.repository.NoticeRepository
import com.academy.healthier.domain.notice.repository.NoticeViewRepository
import com.academy.healthier.domain.user.repository.UserRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class NoticeService(
    private val noticeRepository: NoticeRepository,
    private val noticeViewRepository: NoticeViewRepository,
    private val academyRepository: AcademyRepository,
    private val academyMemberRepository: AcademyMemberRepository,
    private val userRepository: UserRepository
) {

    @Transactional
    fun createNotice(academyId: Long, userId: Long, request: CreateNoticeRequest): NoticeResponse {
        val academy = academyRepository.findById(academyId)
            .orElseThrow { BusinessException(ErrorCode.ACADEMY_NOT_FOUND) }
        val member = academyMemberRepository.findByAcademyIdAndUserId(academyId, userId)
            ?: throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)

        val notice = noticeRepository.save(
            Notice(
                academy = academy,
                author = member,
                title = request.title,
                content = request.content,
                isImportant = request.isImportant
            )
        )

        return NoticeResponse.from(notice)
    }

    fun getNotices(academyId: Long, pageable: Pageable): PageResponse<NoticeResponse> {
        val page = noticeRepository.findByAcademyId(academyId, pageable)
        return PageResponse.from(page) { NoticeResponse.from(it) }
    }

    @Transactional
    fun getNoticeDetail(noticeId: Long, userId: Long): NoticeDetailResponse {
        val notice = noticeRepository.findByIdWithAuthor(noticeId)
            ?: throw BusinessException(ErrorCode.INVALID_INPUT)

        if (!noticeViewRepository.existsByNoticeIdAndUserId(noticeId, userId)) {
            val user = userRepository.findById(userId)
                .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }
            noticeViewRepository.save(NoticeView(notice = notice, user = user))
            noticeRepository.incrementViewCount(noticeId)
            notice.viewCount++
        }

        return NoticeDetailResponse(
            id = notice.id,
            title = notice.title,
            content = notice.content,
            authorName = notice.author.user.name,
            isImportant = notice.isImportant,
            viewCount = notice.viewCount,
            createdAt = notice.createdAt
        )
    }

    @Transactional
    fun updateNotice(
        academyId: Long,
        noticeId: Long,
        request: UpdateNoticeRequest
    ): NoticeResponse {
        val notice = noticeRepository.findById(noticeId)
            .orElseThrow { BusinessException(ErrorCode.INVALID_INPUT) }

        if (notice.academy.id != academyId) {
            throw BusinessException(ErrorCode.INVALID_INPUT)
        }

        notice.title = request.title
        notice.content = request.content
        notice.isImportant = request.isImportant

        return NoticeResponse.from(notice)
    }

    @Transactional
    fun deleteNotice(academyId: Long, noticeId: Long) {
        val notice = noticeRepository.findById(noticeId)
            .orElseThrow { BusinessException(ErrorCode.INVALID_INPUT) }

        if (notice.academy.id != academyId) {
            throw BusinessException(ErrorCode.INVALID_INPUT)
        }

        noticeRepository.delete(notice)
    }
}
