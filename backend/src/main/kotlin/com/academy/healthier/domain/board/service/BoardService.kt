package com.academy.healthier.domain.board.service

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.academy.repository.AcademyRepository
import com.academy.healthier.domain.board.dto.*
import com.academy.healthier.domain.board.entity.BoardAttachment
import com.academy.healthier.domain.board.entity.BoardComment
import com.academy.healthier.domain.board.entity.BoardPost
import com.academy.healthier.domain.board.entity.PostView
import com.academy.healthier.domain.board.repository.BoardAttachmentRepository
import com.academy.healthier.domain.board.repository.BoardCommentRepository
import com.academy.healthier.domain.board.repository.BoardPostRepository
import com.academy.healthier.domain.board.repository.PostViewRepository
import com.academy.healthier.domain.membership.repository.AcademyMemberRepository
import com.academy.healthier.domain.user.repository.UserRepository
import com.academy.healthier.infra.file.AttachmentValidator
import com.academy.healthier.infra.file.FileStorageService
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.multipart.MultipartFile

@Service
@Transactional(readOnly = true)
class BoardService(
    private val boardPostRepository: BoardPostRepository,
    private val boardCommentRepository: BoardCommentRepository,
    private val boardAttachmentRepository: BoardAttachmentRepository,
    private val postViewRepository: PostViewRepository,
    private val academyRepository: AcademyRepository,
    private val academyMemberRepository: AcademyMemberRepository,
    private val userRepository: UserRepository,
    private val fileStorageService: FileStorageService
) {

    companion object {
        private const val ATTACHMENT_DIR = "board"
        private const val MAX_ATTACHMENTS_PER_POST = 5
    }

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

    @Transactional
    fun updatePost(postId: Long, userId: Long, request: CreateBoardPostRequest): BoardPostResponse {
        val post = boardPostRepository.findByIdWithAuthor(postId)
            ?: throw BusinessException(ErrorCode.INVALID_INPUT)
        if (post.author.user.id != userId) throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        post.title = request.title
        post.content = request.content
        return BoardPostResponse.from(post)
    }

    @Transactional
    fun deletePost(postId: Long, userId: Long, academyId: Long) {
        val post = boardPostRepository.findByIdWithAuthor(postId)
            ?: throw BusinessException(ErrorCode.INVALID_INPUT)
        val member = academyMemberRepository.findByAcademyIdAndUserId(academyId, userId)
            ?: throw BusinessException(ErrorCode.NOT_ACADEMY_MEMBER)
        // 본인 또는 학원 관리자만 삭제 가능
        if (post.author.user.id != userId && member.role != com.academy.healthier.domain.membership.entity.MemberRole.ACADEMY_ADMIN) {
            throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        }
        boardPostRepository.delete(post)
    }

    @Transactional
    fun updateComment(commentId: Long, userId: Long, content: String): CommentResponse {
        val comment = boardCommentRepository.findById(commentId)
            .orElseThrow { BusinessException(ErrorCode.INVALID_INPUT) }
        if (comment.author.user.id != userId) throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        comment.content = content
        return CommentResponse(
            id = comment.id,
            content = comment.content,
            authorName = comment.author.user.name,
            authorId = comment.author.id,
            parentId = comment.parent?.id,
            createdAt = comment.createdAt
        )
    }

    @Transactional
    fun deleteComment(commentId: Long, userId: Long) {
        val comment = boardCommentRepository.findById(commentId)
            .orElseThrow { BusinessException(ErrorCode.INVALID_INPUT) }
        if (comment.author.user.id != userId) throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        boardCommentRepository.delete(comment)
    }

    @Transactional
    fun uploadAttachments(
        postId: Long,
        userId: Long,
        files: List<MultipartFile>
    ): List<AttachmentResponse> {
        val post = boardPostRepository.findByIdWithAuthor(postId)
            ?: throw BusinessException(ErrorCode.INVALID_INPUT)
        if (post.author.user.id != userId) {
            throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        }

        val existingCount = boardAttachmentRepository.findByPostId(postId).size
        if (existingCount + files.size > MAX_ATTACHMENTS_PER_POST) {
            throw BusinessException(ErrorCode.ATTACHMENT_LIMIT_EXCEEDED)
        }

        files.forEach(AttachmentValidator::validate)

        val saved = files.map { file ->
            val stored = fileStorageService.store(file, ATTACHMENT_DIR)
            boardAttachmentRepository.save(
                BoardAttachment(
                    post = post,
                    originalFilename = stored.originalFilename,
                    storedFilename = stored.storedFilename,
                    filePath = stored.filePath,
                    fileSize = stored.fileSize,
                    contentType = stored.contentType
                )
            )
        }

        return saved.map {
            AttachmentResponse(
                id = it.id,
                originalFilename = it.originalFilename,
                fileSize = it.fileSize,
                contentType = it.contentType
            )
        }
    }

    fun getAttachment(postId: Long, attachmentId: Long): BoardAttachment {
        val attachment = boardAttachmentRepository.findById(attachmentId)
            .orElseThrow { BusinessException(ErrorCode.ATTACHMENT_NOT_FOUND) }
        if (attachment.post.id != postId) {
            throw BusinessException(ErrorCode.ATTACHMENT_NOT_FOUND)
        }
        return attachment
    }

    @Transactional
    fun deleteAttachment(postId: Long, attachmentId: Long, userId: Long) {
        val attachment = getAttachment(postId, attachmentId)
        if (attachment.post.author.user.id != userId) {
            throw BusinessException(ErrorCode.INSUFFICIENT_ROLE)
        }
        fileStorageService.delete(attachment.filePath)
        boardAttachmentRepository.delete(attachment)
    }
}
