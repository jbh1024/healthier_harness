---
paths:
  - "frontend/**"
---

# Frontend 테스트 가이드 (Flutter + Playwright MCP)

## 프레임워크
- **flutter_test** (위젯/단위 테스트)
- **Playwright MCP** (E2E 테스트) — DevTools MCP 대비 고수준 API로 토큰 소모 적음

## 테스트 분류
| 분류 | 대상 | 위치 |
|------|------|------|
| 단위 테스트 | Provider, Model, Util | `test/unit/` |
| 위젯 테스트 | 개별 위젯 렌더링/인터랙션 | `test/widget/` |
| E2E 테스트 | 사용자 시나리오 전체 흐름 | `test/e2e/` (Playwright) |

## 실행 명령어
```bash
cd frontend
flutter test                           # 전체 테스트
flutter test test/unit/                # 단위 테스트만
flutter test --coverage                # 커버리지 리포트
```

## 작성 규칙
- `testWidgets`로 위젯 테스트 작성
- Provider 테스트는 `ProviderContainer`로 격리
- E2E는 주요 사용자 플로우(로그인, 수강신청 등) 중심
