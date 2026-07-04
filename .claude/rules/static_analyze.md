# 정적분석

## 공통 원칙
- CI(`.github/workflows/ci.yml`)에서 정적분석 강제 — Backend `ktlintCheck detekt`, Frontend `dart analyze --fatal-infos`
- 커밋 전 로컬에서 실행 권장 (CI 실패 예방)
- 커밋 전 staging 된 파일에 비밀번호나 secret key 하드코딩 되어있는지 검토.
