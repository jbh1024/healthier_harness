---
name: new-feature
description: "작업 내용을 기반으로 피처 브랜치를 자동 생성합니다. 영문 요약을 생성한 후 'feature/영문요약_작업일시' 형식의 브랜치를 생성합니다."
---

# New Feature Branch

작업 내용 기반 피처 브랜치 자동 생성

## 실행 과정

### 1. 작업 내용 입력 받기
- 사용자에게 일감번호 요청 (선택 사항)
- 작업 내용(일감 제목) 입력 요청
- 일감번호가 없으면 `0`으로 설정

### 2. 영문 요약 생성
- 일감 제목 또는 작업 내용을 분석
- 영어로 간결한 요약 생성 (최대 50자, snake_case)
- 변환 규칙:
  - 소문자 사용
  - 공백 → 언더스코어(_)
  - 특수문자 제거
  - 동사 + 명사 형태 권장

**예시:**
- "사용자 로그인 기능 추가" → `add_user_login`
- "권한변경 페이지 오류 수정" → `fix_permission_page_error`
- "JWT 토큰 인증 구현" → `implement_jwt_auth`

### 3. 사용자 확인
- 생성된 영문 요약을 사용자에게 보여주고 수정 여부 확인
- AskUserQuestion 사용:
  ```
  브랜치명: feature/{일감번호}_{영문요약}

  이대로 사용하시겠습니까?
  - "그대로 사용" (Recommended)
  - "수정하기"
  ```

### 4. Base 브랜치 결정

- main을 base 브랜치로 브랜치 생성.

### 5. 브랜치 생성

**생성 전 확인:**
- Git 작업 디렉토리 상태 확인 (`git status`)
- 커밋되지 않은 변경사항이 있으면 경고
- 같은 이름의 브랜치가 이미 존재하는지 확인

**브랜치 생성:**
```bash
git checkout -b feature/{일감번호}_{영문요약} {base_branch}
```

**브랜치명 예시**
- `feature/fix_permission_page_error`
- `feature/implement_jwt_auth`

### 6. 결과 출력

```
✅ 피처 브랜치가 생성되었습니다!

- 브랜치명: feature/262118_fix_permission_page_error
- Base 브랜치: main
- 현재 위치: {커밋 해시}

다음 단계:
1. 코드 구현 및 검증 진행.
```

## 주의사항

- Git 작업 디렉토리가 깨끗한지 확인
- 같은 이름의 브랜치가 이미 존재하지 않는지 확인
- Base 브랜치가 최신 상태인지 확인 (`git pull`)
