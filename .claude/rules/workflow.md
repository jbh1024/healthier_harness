# 구현 워크플로우

## 전체 흐름

```
계획 수립 → [Phase 단위 반복: 구현 → 검증 → 문서 업데이트] → 커밋
```

---

## 1. 계획 수립

- PRD(`docs/PRD/PRD.md`) 로드맵 기반으로 Phase별 구현 계획 수립
- `docs/plan/요청내용_날짜_plan.md` 파일 생성
- 계획 내용: Phase별 목표, DB 스키마, Backend/Frontend 구현 범위, 주요 설계 결정

---

## 2. Phase 단위 구현 사이클

### 2-1. 구현 순서 (Backend → Frontend)

**Backend**
1. DB 마이그레이션 (Flyway SQL)
2. JPA 엔티티
3. Repository
4. DTO (Request/Response)
5. Service (비즈니스 로직)
6. Controller (REST API)

**Frontend**
1. 도메인 모델 (Dart 클래스)
2. Repository (Dio API 호출)
3. Provider (Riverpod 상태 관리)
4. 화면 (Screen 위젯)
5. 라우터 경로 추가

### 2-2. 검증

- **Backend**: `./gradlew compileKotlin` → `./gradlew test`
- **Frontend**: `dart analyze`
- 각 도메인 구현 후 중간 컴파일 검증 실시
- Phase 완료 시 전체 테스트 실행
- 검증시 에러발생시 2-1 단계부터 다시 구현 작업을 수행.

### 2-3. 문서 업데이트

Phase 완료 시 `docs/plan/` 계획 문서에 다음을 기록:
- `doc_write.md` 준수
- **완료일/상태** 업데이트
- **실제 구현 내용** (버전, 파일 수, API 목록 등)
- **의사결정** (채택한 방식과 근거)
- **검증 결과** (빌드/분석 통과 여부)

---

## 3. 커밋

- Phase 완료 + 검증 통과 + 문서 업데이트 후 커밋
- `git_convention.md` 준수
- 커밋 단위: Phase 또는 의미 있는 작업 단위

---

## 4. 작업 추적

- Task 도구로 Phase 내 세부 작업 생성/추적
- 작업 시작 시 `in_progress`, 완료 시 `completed` 상태 변경
- 빌드 실패 시 원인 분석 후 수정, 동일 작업 내에서 해결

---

## 5. 원칙

- **Backend 먼저, Frontend 나중**: API가 정의되어야 프론트 연동 가능
- **중간 검증 필수**: 도메인 하나 완성할 때마다 `compileKotlin` 실행
- **문서는 구현과 동기화**: 구현이 끝났으면 문서도 끝나야 함
- **계획 변경 시 문서 반영**: 구현 중 설계가 바뀌면 plan 문서의 의사결정에 기록
