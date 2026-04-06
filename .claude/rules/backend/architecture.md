---
paths:
  - "backend/**"
---

# Backend 아키텍쳐

## 기술 스택
- **Spring Boot 3.3 + Kotlin 1.9** / JDK 21 / Gradle
- 패키지 루트: `com.academy.healthier`

## 패키지 구조
```
backend/src/main/kotlin/com/academy/healthier/
├── config/      # 설정 (JPA, CORS, Security)
├── common/      # 공통 (BaseEntity, 예외, 응답)
├── domain/      # 도메인별 패키지
│   ├── user/
│   ├── course/
│   ├── enrollment/
│   ├── board/
│   └── notice/
└── infra/       # 외부 연동
```

## 핵심 규칙
- **도메인 패키지 구조**: `domain/{도메인}/entity`, `domain/{도메인}/repository` — 현재 Service/Controller 레이어 미구현
- **공통**: `common/BaseEntity` (id, createdAt, updatedAt 감사 필드), `common/response/ApiResponse` (통일 응답 래퍼), `common/exception/` (BusinessException 계층 + GlobalExceptionHandler)
- **DB**: MySQL 8.0, Flyway 마이그레이션 (`src/main/resources/db/migration/`)
- **프로필**: `dev` (ddl-auto=update, SQL 로깅), `test` (H2, create-drop, Flyway 비활성화)
- API prefix: `/api`, Swagger UI: `/api/swagger-ui.html`
