-- 초대코드 테이블
CREATE TABLE invite_codes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    academy_id BIGINT NOT NULL,
    code VARCHAR(20) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL,
    granted_credits INT NOT NULL DEFAULT 0,
    max_uses INT NULL,
    current_uses INT NOT NULL DEFAULT 0,
    unlimited BOOLEAN NOT NULL DEFAULT FALSE,
    expires_at DATETIME(6) NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_by BIGINT NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_invite_academy FOREIGN KEY (academy_id) REFERENCES academies(id),
    CONSTRAINT fk_invite_created_by FOREIGN KEY (created_by) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_invite_codes_academy ON invite_codes(academy_id);
