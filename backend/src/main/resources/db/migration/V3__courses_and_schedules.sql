-- 수업 테이블
CREATE TABLE courses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    academy_id BIGINT NOT NULL,
    instructor_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    max_capacity INT NOT NULL DEFAULT 20,
    current_enrollment INT NOT NULL DEFAULT 0,
    enrollment_type VARCHAR(20) NOT NULL DEFAULT 'AUTO_APPROVE',
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_course_academy FOREIGN KEY (academy_id) REFERENCES academies(id),
    CONSTRAINT fk_course_instructor FOREIGN KEY (instructor_id) REFERENCES academy_members(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_courses_academy ON courses(academy_id);
CREATE INDEX idx_courses_status ON courses(academy_id, status);

-- 수업 일정 테이블
CREATE TABLE course_schedules (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    course_id BIGINT NOT NULL,
    schedule_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    CONSTRAINT fk_schedule_course FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_schedules_course ON course_schedules(course_id);
CREATE INDEX idx_schedules_date ON course_schedules(course_id, schedule_date);
