---
paths:
  - "backend/**"
---

# Backend 정적분석 (ktlint + detekt)

## ktlint — 코드 스타일
- Kotlin 공식 코딩 컨벤션 준수
- 자동 포맷팅 지원

```bash
cd backend
./gradlew ktlintCheck       # 스타일 검사
./gradlew ktlintFormat      # 자동 수정
```

## detekt — 코드 품질
- 복잡도, 코드 스멜, 잠재적 버그 탐지
- 설정 파일: `backend/config/detekt/detekt.yml`

```bash
cd backend
./gradlew detekt            # 정적분석 실행
```

## 복합 실행
```bash
cd backend
./gradlew ktlintCheck detekt   # ktlint + detekt 동시 실행
```
