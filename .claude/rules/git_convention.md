# 프로젝트 깃 컨벤션

## Git 브랜치 전략

```
main          ← 운영 배포
  └── develop ← 개발 통합
       ├── feature/xxx  ← 기능 개발
       └── fix/xxx      ← 버그 수정
```

## Git 커밋 컨벤션

### 형식
```
<type>(<scope>): <subject>

<body>

Co-Authored-By: Claude
```

### 커밋 타입

| 타입 | 용도 | 예시 |
|------|------|------|
| **feat** | 새로운 기능 추가 | `feat(auth): 소셜 로그인 기능 추가` |
| **fix** | 버그 수정 | `fix(api): 로그인 오류 수정` |
| **docs** | 문서 수정 (코드 변경 없음) | `docs(readme): 설치 가이드 업데이트` |
| **style** | 코드 형식/포맷 변경 (기능 변화 없음) | `style(global): 들여쓰기 규칙 통일` |
| **refactor** | 리팩토링 (기능 추가/버그 수정 아님) | `refactor(user-service): 로직 최적화` |
| **test** | 테스트 코드 추가/수정 | `test(api): 인증 기능 테스트 추가` |
| **chore** | 빌드, 패키지 등 코드 외 작업 | `chore(build): 의존성 패키지 업데이트` |
| **perf** | 성능 개선 | `perf(images): 이미지 로딩 속도 개선` |
| **BREAKING CHANGE** | 호환성을 깨는 변경 | `BREAKING CHANGE: 스키마가 변경되었습니다` |

### 작성 규칙
- subject는 수정한 내용을 개조식으로 요약
- body는 변경 이유, 상세 내용을 개조식으로 작성 (선택)
- 메시지 하단에 "커밋메시지 작성자(commit message written by)" 정보에 작업한 모델명만 기입
  - 예: `Commit Message Co-Written By : Claude`