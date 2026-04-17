package com.academy.healthier.common.exception

import org.springframework.http.HttpStatus

enum class ErrorCode(
    val status: HttpStatus,
    val code: String,
    val message: String
) {
    // 공통
    INVALID_INPUT(HttpStatus.BAD_REQUEST, "COMMON_001", "잘못된 입력입니다"),
    INTERNAL_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "COMMON_002", "서버 내부 오류가 발생했습니다"),

    // 인증
    UNAUTHORIZED(HttpStatus.UNAUTHORIZED, "AUTH_001", "인증이 필요합니다"),
    INVALID_TOKEN(HttpStatus.UNAUTHORIZED, "AUTH_002", "유효하지 않은 토큰입니다"),
    EXPIRED_TOKEN(HttpStatus.UNAUTHORIZED, "AUTH_003", "만료된 토큰입니다"),
    DUPLICATE_EMAIL(HttpStatus.CONFLICT, "AUTH_004", "이미 사용중인 이메일입니다"),
    INVALID_CREDENTIALS(HttpStatus.UNAUTHORIZED, "AUTH_005", "이메일 또는 비밀번호가 올바르지 않습니다"),
    INVALID_PASSWORD_FORMAT(HttpStatus.BAD_REQUEST, "AUTH_006", "비밀번호는 8자 이상, 영문+숫자+특수문자 조합이어야 합니다"),
    INVALID_REFRESH_TOKEN(HttpStatus.UNAUTHORIZED, "AUTH_007", "유효하지 않은 리프레시 토큰입니다"),
    INVALID_RESET_TOKEN(HttpStatus.BAD_REQUEST, "AUTH_008", "유효하지 않은 비밀번호 재설정 토큰입니다"),
    RESET_TOKEN_EXPIRED(HttpStatus.BAD_REQUEST, "AUTH_009", "만료된 비밀번호 재설정 토큰입니다"),
    RESET_TOKEN_ALREADY_USED(HttpStatus.BAD_REQUEST, "AUTH_010", "이미 사용된 비밀번호 재설정 토큰입니다"),

    // 사용자
    USER_NOT_FOUND(HttpStatus.NOT_FOUND, "USER_001", "사용자를 찾을 수 없습니다"),

    // 학원
    ACADEMY_NOT_FOUND(HttpStatus.NOT_FOUND, "ACADEMY_001", "학원을 찾을 수 없습니다"),
    ACADEMY_INACTIVE(HttpStatus.BAD_REQUEST, "ACADEMY_002", "비활성화된 학원입니다"),

    // 멤버십
    NOT_ACADEMY_MEMBER(HttpStatus.FORBIDDEN, "MEMBER_001", "해당 학원의 멤버가 아닙니다"),
    INSUFFICIENT_ROLE(HttpStatus.FORBIDDEN, "MEMBER_002", "권한이 부족합니다"),
    ALREADY_MEMBER(HttpStatus.CONFLICT, "MEMBER_003", "이미 해당 학원의 멤버입니다"),

    // 초대코드
    INVITE_CODE_NOT_FOUND(HttpStatus.NOT_FOUND, "INVITE_001", "초대코드를 찾을 수 없습니다"),
    INVITE_CODE_EXPIRED(HttpStatus.BAD_REQUEST, "INVITE_002", "만료된 초대코드입니다"),
    INVITE_CODE_EXHAUSTED(HttpStatus.BAD_REQUEST, "INVITE_003", "초대코드 사용 횟수를 초과했습니다"),

    // 수업
    COURSE_NOT_FOUND(HttpStatus.NOT_FOUND, "COURSE_001", "수업을 찾을 수 없습니다"),
    COURSE_NOT_OPEN(HttpStatus.BAD_REQUEST, "COURSE_002", "수강 신청이 불가능한 수업입니다"),

    // 수강 신청
    DUPLICATE_ENROLLMENT(HttpStatus.CONFLICT, "ENROLL_001", "이미 수강 신청한 수업입니다"),
    INSUFFICIENT_CREDITS(HttpStatus.BAD_REQUEST, "ENROLL_002", "수강 잔여 횟수가 부족합니다. 관리자에게 문의하세요"),
    ENROLLMENT_NOT_FOUND(HttpStatus.NOT_FOUND, "ENROLL_003", "수강 신청 내역을 찾을 수 없습니다"),

    // 파일/첨부파일
    INVALID_ATTACHMENT(HttpStatus.BAD_REQUEST, "FILE_001", "첨부파일이 비어 있습니다"),
    ATTACHMENT_TOO_LARGE(HttpStatus.BAD_REQUEST, "FILE_002", "첨부파일 크기는 10MB 이하여야 합니다"),
    UNSUPPORTED_ATTACHMENT_TYPE(HttpStatus.BAD_REQUEST, "FILE_003", "지원하지 않는 파일 형식입니다"),
    ATTACHMENT_LIMIT_EXCEEDED(HttpStatus.BAD_REQUEST, "FILE_004", "게시글당 첨부파일은 최대 5개까지 등록할 수 있습니다"),
    ATTACHMENT_NOT_FOUND(HttpStatus.NOT_FOUND, "FILE_005", "첨부파일을 찾을 수 없습니다"),
}
