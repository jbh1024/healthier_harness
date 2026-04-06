---
paths:
  - "frontend/**"
---

# Frontend 정적분석 (flutter_lints)

## flutter_lints
- `analysis_options.yaml`에서 규칙 관리
- `flutter_lints` 패키지 기반 기본 규칙 세트 적용

```bash
cd frontend
dart analyze                # 정적분석 실행
dart fix --apply            # 자동 수정 가능 항목 일괄 적용
```

## 주요 규칙
- `prefer_const_constructors`
- `avoid_print` (디버그 외 print 금지)
- `prefer_final_locals`
