package com.academy.healthier.domain.board.controller

import com.academy.healthier.common.annotation.CurrentUser
import com.academy.healthier.common.response.ApiResponse
import com.academy.healthier.common.response.PageResponse
import com.academy.healthier.domain.board.dto.*
import com.academy.healthier.domain.board.service.BoardService
import com.academy.healthier.security.AcademyAuth
import com.academy.healthier.security.UserPrincipal
import jakarta.validation.Valid
import org.springframework.data.domain.Pageable
import org.springframework.data.web.PageableDefault
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/academies/{academyId}/board")
class BoardController(
    private val boardService: BoardService
) {

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @AcademyAuth
    fun createPost(
        @PathVariable academyId: Long,
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: CreateBoardPostRequest
    ): ApiResponse<BoardPostResponse> {
        return ApiResponse.ok(boardService.createPost(academyId, user.userId, request))
    }

    @GetMapping
    @AcademyAuth
    fun getPosts(
        @PathVariable academyId: Long,
        @PageableDefault(size = 20) pageable: Pageable
    ): ApiResponse<PageResponse<BoardPostResponse>> {
        return ApiResponse.ok(boardService.getPosts(academyId, pageable))
    }

    @GetMapping("/{postId}")
    @AcademyAuth
    fun getPostDetail(
        @PathVariable academyId: Long,
        @PathVariable postId: Long,
        @CurrentUser user: UserPrincipal
    ): ApiResponse<BoardPostDetailResponse> {
        return ApiResponse.ok(boardService.getPostDetail(postId, user.userId))
    }

    @PostMapping("/{postId}/comments")
    @ResponseStatus(HttpStatus.CREATED)
    @AcademyAuth
    fun createComment(
        @PathVariable academyId: Long,
        @PathVariable postId: Long,
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: CreateCommentRequest
    ): ApiResponse<CommentResponse> {
        return ApiResponse.ok(boardService.createComment(postId, user.userId, academyId, request))
    }

    @PutMapping("/{postId}")
    @AcademyAuth
    fun updatePost(
        @PathVariable academyId: Long,
        @PathVariable postId: Long,
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: CreateBoardPostRequest
    ): ApiResponse<BoardPostResponse> {
        return ApiResponse.ok(boardService.updatePost(postId, user.userId, request))
    }

    @DeleteMapping("/{postId}")
    @AcademyAuth
    fun deletePost(
        @PathVariable academyId: Long,
        @PathVariable postId: Long,
        @CurrentUser user: UserPrincipal
    ): ApiResponse<Unit> {
        boardService.deletePost(postId, user.userId, academyId)
        return ApiResponse.ok()
    }

    @PutMapping("/{postId}/comments/{commentId}")
    @AcademyAuth
    fun updateComment(
        @PathVariable academyId: Long,
        @PathVariable postId: Long,
        @PathVariable commentId: Long,
        @CurrentUser user: UserPrincipal,
        @Valid @RequestBody request: CreateCommentRequest
    ): ApiResponse<CommentResponse> {
        return ApiResponse.ok(boardService.updateComment(commentId, user.userId, request.content))
    }

    @DeleteMapping("/{postId}/comments/{commentId}")
    @AcademyAuth
    fun deleteComment(
        @PathVariable academyId: Long,
        @PathVariable postId: Long,
        @PathVariable commentId: Long,
        @CurrentUser user: UserPrincipal
    ): ApiResponse<Unit> {
        boardService.deleteComment(commentId, user.userId)
        return ApiResponse.ok()
    }
}
