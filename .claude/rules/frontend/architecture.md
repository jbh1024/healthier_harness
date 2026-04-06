---
paths:
  - "frontend/**"
---

# Frontend 아키텍쳐

## 기술 스택
- **Flutter** 크로스플랫폼 (Android, iOS, Windows, macOS, Linux)
- **상태관리**: Riverpod (riverpod_annotation + riverpod_generator)
- **라우팅**: GoRouter with StatefulShellRoute (하단 탭 4개: 홈, 수업, 게시판, 공지)
- **네트워크**: Dio + Retrofit (코드 생성 방식)
- **모델**: Freezed + json_serializable (코드 생성 방식)
- **테마**: Material 3, primary `#4A90D9`, border radius 12px

## 패키지 구조
```
frontend/lib/
├── core/            # 공통 (테마, 네트워크, 상수)
├── features/        # 기능별 패키지
│   ├── auth/
│   ├── course/
│   ├── enrollment/
│   ├── board/
│   └── notice/
└── routing/         # GoRouter 라우팅
```

## 핵심 규칙
- API base URL: `core/constants/api_constants.dart`에서 관리
- 현재 모든 feature 화면은 placeholder 상태
