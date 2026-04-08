package com.academy.healthier.domain.board.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.academy.repository.AcademyRepository
import com.academy.healthier.domain.board.dto.*
import com.academy.healthier.domain.board.entity.BoardComment
import com.academy.healthier.domain.board.entity.BoardPost
import com.academy.healthier.domain.board.entity.PostView
import com.academy.healthier.domain.board.repository.BoardAttachmentRepository
import com.academy.healthier.domain.board.repository.BoardCommentRepository
import com.academy.healthier.domain.board.repository.BoardPostRepository
import com.academy.healthier.domain.board.repository.PostViewRepository
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import com.academy.healthier.domain.user.repository.UserRepository
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
@Transactional(readOnly = true)
class BoardService(
    private val boardPostRepository: BoardPostRepository,
    private val boardCommentRepository: BoardCommentRepository,
    private val boardAttachmentRepository: BoardAttachmentRepository,
    private val postViewRepository: PostViewRepository,
    private val academyRepository: AcademyRepository,
    private val academyMemberRepository: AcademyMemberRepository,
    private val userRepository: UserRepository
) {

    @Transactional
    fun createPost(academyId: Long, userId: Long, request: CreateBoardPostRequest): BoardPostResponse {
        val academy = academyRepository.findById(academyId)
            .orElseThrow { BusinessException(ErrorCode.ACADEMY_NOT_FOUND) }
        val member = academyMemberRepository.findByAcademyIdAndUserId(academyId, userId)
            ?: throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)

        val post = boardPostRepository.save(
            BoardPost(
                academy = academy,
                author = member,
                title = request.title,
                content = request.content
            )
        )

        return BoardPostResponse.from(post)
    }

    fun getPosts(academyId: Long, pageable: Pageable): PageResponse<BoardPostResponse> {
        val page = boardPostRepository.findByAcademyId(academyId, pageable)
        return PageResponse.from(page) { BoardPostResponse.from(it) }
    }

    @Transactional
    fun getPostDetail(postId: Long, userId: Long): BoardPostDetailResponse {
        val post = boardPostRepository.findByIdWithAuthor(postId)
            ?: throw BusinessException(ErrorCode.INVALID_INPUT)

        // 조회수 처리: 사용자 기반 중복 방지
        if (!postViewRepository.existsByPostIdAndUserId(postId, userId)) {
            val user = userRepository.findById(userId)
                .orElseThrow { BusinessException(ErrorCode.USER_NOT_FOUND) }
            postViewRepository.save(PostView(post = post, user = user))
            boardPostRepository.incrementViewCount(postId)
            post.viewCount++
        }

        val comments = boardCommentRepository.findByPostIdWithAuthor(postId)
        val attachments = boardAttachmentRepository.findByPostId(postId)

        return BoardPostDetailResponse(
            id = post.id,
            title = post.title,
            content = post.content,
            authorName = post.author.user.name,
            authorId = post.author.id,
            isPinned = post.isPinned,
            viewCount = post.viewCount,
            comments = comments.map { c ->
                CommentResponse(
                    id = c.id,
                    content = c.content,
                    authorName = c.author.user.name,
                    authorId = c.author.id,
                    parentId = c.parent?.id,
                    createdAt = c.createdAt
                )
            },
            attachments = attachments.map { a ->
                AttachmentResponse(
                    id = a.id,
                    originalFilename = a.originalFilename,
                    fileSize = a.fileSize,
                    contentType = a.contentType
                )
            },
            createdAt = post.createdAt
        )
    }

    @Transactional
    fun createComment(postId: Long, userId: Long, academyId: Long, request: CreateCommentRequest): CommentResponse {
        val post = boardPostRepository.findById(postId)
            .orElseThrow { BusinessException(ErrorCode.INVALID_INPUT) }
        val member = academyMemberRepository.findByAcademyIdAndUserId(academyId, userId)
            ?: throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)

        var parent: BoardComment? = null
        if (request.parentId != null) {
            parent = boardCommentRepository.findById(request.parentId).orElse(null)
            // 대댓글의 대댓글 방지
            if (parent?.parent != null) {
                throw BusinessException(ErrorCode.INVALID_INPUT)
            }
        }

        val comment = boardCommentRepository.save(
            BoardComment(
                post = post,
                author = member,
                parent = parent,
                content = request.content
            )
        )

        return CommentResponse(
            id = comment.id,
            content = comment.content,
            authorName = comment.author.user.name,
            authorId = comment.author.id,
            parentId = comment.parent?.id,
            createdAt = comment.createdAt
        )
    }
}
