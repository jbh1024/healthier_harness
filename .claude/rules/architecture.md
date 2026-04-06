# 프로젝트 아키텍쳐

## 프로젝트 구조

```
healthier/
├── backend/                 # Kotlin + Spring Boot API 서버
├── frontend/                # Flutter 크로스플랫폼 클라이언트
├── docs/                    # API 스펙, 설계 문서
├── .github/workflows/       # CI/CD
└── docker-compose.yml       # 로컬 개발 환경
```

## Core 도메인
- **User**: STUDENT, INSTRUCTOR, ADMIN 역할
- **Course**: 수업 (OPEN → IN_PROGRESS → COMPLETED / CLOSED)
- **Enrollment**: 수강 신청 (PENDING → APPROVED / REJECTED / CANCELLED)
- **Board**: 자유 게시판 (고정글 지원)
- **Notice**: 공지사항 (중요 공지 지원)
