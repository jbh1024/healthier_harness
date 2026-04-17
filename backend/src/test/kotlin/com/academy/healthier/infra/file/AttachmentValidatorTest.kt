package com.academy.healthier.infra.file

import com.academy.healthier.common.exception.BusinessException
import com.academy.healthier.common.exception.ErrorCode
import org.assertj.core.api.Assertions.assertThat
import org.assertj.core.api.Assertions.assertThatThrownBy
import org.junit.jupiter.api.Test
import org.springframework.mock.web.MockMultipartFile

class AttachmentValidatorTest {

    private fun file(
        name: String = "sample.pdf",
        contentType: String = "application/pdf",
        content: ByteArray = byteArrayOf(1, 2, 3)
    ) = MockMultipartFile("file", name, contentType, content)

    @Test
    fun `허용 이미지 파일은 검증 통과`() {
        AttachmentValidator.validate(file("photo.jpg", "image/jpeg"))
        AttachmentValidator.validate(file("pic.png", "image/png"))
        AttachmentValidator.validate(file("anim.gif", "image/gif"))
    }

    @Test
    fun `허용 문서 파일은 검증 통과`() {
        AttachmentValidator.validate(file("doc.pdf", "application/pdf"))
        AttachmentValidator.validate(file("doc.docx",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"))
    }

    @Test
    fun `빈 파일은 INVALID_ATTACHMENT 예외 발생`() {
        val empty = MockMultipartFile("file", "a.pdf", "application/pdf", ByteArray(0))
        assertThatThrownBy { AttachmentValidator.validate(empty) }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.INVALID_ATTACHMENT)
    }

    @Test
    fun `10MB 초과 파일은 ATTACHMENT_TOO_LARGE 예외 발생`() {
        val big = MockMultipartFile(
            "file", "big.pdf", "application/pdf", ByteArray(10 * 1024 * 1024 + 1)
        )
        assertThatThrownBy { AttachmentValidator.validate(big) }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.ATTACHMENT_TOO_LARGE)
    }

    @Test
    fun `허용되지 않은 MIME 타입은 UNSUPPORTED_ATTACHMENT_TYPE 예외 발생`() {
        val exe = file("bad.exe", "application/x-msdownload")
        assertThatThrownBy { AttachmentValidator.validate(exe) }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.UNSUPPORTED_ATTACHMENT_TYPE)
    }

    @Test
    fun `허용되지 않은 확장자는 UNSUPPORTED_ATTACHMENT_TYPE 예외 발생`() {
        val mismatched = file("hidden.exe", "image/jpeg")
        assertThatThrownBy { AttachmentValidator.validate(mismatched) }
            .isInstanceOf(BusinessException::class.java)
            .extracting("errorCode")
            .isEqualTo(ErrorCode.UNSUPPORTED_ATTACHMENT_TYPE)
    }

    @Test
    fun `확장자 대소문자 구분 없이 검증 통과`() {
        AttachmentValidator.validate(file("PHOTO.JPG", "image/jpeg"))
    }

    @Test
    fun `정확히 10MB 크기는 허용`() {
        val tenMb = MockMultipartFile(
            "file", "ok.pdf", "application/pdf", ByteArray(10 * 1024 * 1024)
        )
        AttachmentValidator.validate(tenMb)
        assertThat(tenMb.size).isEqualTo(10L * 1024 * 1024)
    }
}
