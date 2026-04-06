# Healthier - 학원 수강 신청 앱 PRD (Product Requirements Document)

## 1. 제품 개요

### 1.1 목적
여러 학원이 하나의 플랫폼에서 수업 수강 신청, 게시판, 공지사항 기능을 이용할 수 있도록 하는 멀티테넌트 학원 관리 앱.

### 1.2 대상 사용자

| 역할 | 범위 | 설명 |
|------|------|------|
| **시스템 관리자 (SYSTEM_ADMIN)** | 플랫폼 전체 | 학원 생성/관리. 단일 계정 |
| **학원 관리자 (ACADEMY_ADMIN)** | 학원 내 | 학원 설정, 초대코드 관리, 수업/공지/게시판 관리. 학원당 1명 |
| **강사 (INSTRUCTOR)** | 학원 내 | 담당 수업 관리, 수강 신청 승인/거절 |
| **수강생 (STUDENT)** | 학원 내 | 수업 조회, 수강 신청, 게시판 이용 |

> **핵심 규칙**: 계정은 글로벌(이메일 1개 = 1계정). 역할은 학원별 멤버십으로 부여.
> 한 사용자가 A학원 강사 + B학원 수강생일 수 있다.

### 1.3 지원 플랫폼
- 모바일: Android, iOS
- 데스크톱: Windows, macOS, Linux

---

## 2. 도메인 모델

```
Platform
 └── Academy (학원)
      ├── AcademyMember (멤버십: User + Role + 수강 잔여 횟수)
      ├── InviteCode (초대코드: 부여 수강 횟수 포함)
      ├── Course (수업)
      │    ├── CourseSchedule (수업 일정: 월별/반복)
      │    └── Enrollment (수강 신청)
      ├── BoardPost (게시판)
      │    ├── BoardComment (댓글/대댓글)
      │    └── BoardAttachment (첨부파일)
      ├── Notice (공지사항)
      └── Notification (알림 이력)

User (글로벌 계정, 프로필 이미지 포함)
 ├── AcademyMember (N개 학원 소속 가능)
 └── NotificationSetting (알림 수신 설정)
```

### 주요 관계
- `User` ↔ `Academy`: N:M (AcademyMember를 통해 연결, 학원별 역할 + 수강 잔여 횟수 보유)
- `Academy` → `Course`, `BoardPost`, `Notice`: 1:N (모든 리소스는 학원에 종속)
- `Course` → `CourseSchedule`: 1:N (수업별 개별 일정, 반복 생성 지원)
- `Course` → `Enrollment`: 1:N
- `User` → `Enrollment`: 1:N (학원 멤버십을 통해)
- `BoardPost` → `BoardComment`: 1:N (댓글 + 대댓글은 self-referencing)
- `BoardPost` → `BoardAttachment`: 1:N
- `User` → `NotificationSetting`: 1:1 (알림 종류별 on/off)
- `Academy` → `Notification`: 1:N (알림 이력)

---

## 3. 핵심 기능 요구사항

### 3.1 인증 (Auth)

| ID      | 기능             | 우선순위 | 설명                                                  |
|---------|----------------|------|-----------------------------------------------------|
| AUTH-01 | 회원가입           | P0   | 이메일, 비밀번호, 이름, 전화번호 입력. 초대코드로 학원 가입 및 역할(수강생/강사) 부여 |
| AUTH-02 | 로그인            | P0   | 이메일 + 비밀번호 인증, JWT 토큰 발급                            |
| AUTH-03 | 로그아웃           | P0   | 토큰 무효화 및 로컬 저장소 초기화                                 |
| AUTH-04 | 토큰 갱신          | P1   | Access Token 만료 시 Refresh Token으로 자동 갱신             |
| AUTH-05 | 비밀번호 변경        | P2   | 현재 비밀번호 확인 후 변경                                     |
| AUTH-06 | 비밀번호 찾기        | P1   | 이메일 인증(인증 완료 시) 또는 SMS 인증(인증 완료 시), 미인증 시 관리자 문의 안내 |
| AUTH-07 | 간편 로그인 연동      | P2   | Google 계정을 로그인 계정에 연동 통한                            |
| AUTH-08 | 간편 로그인         | P2   | Google 계정을 통한 간편 로그인                                |
| AUTH-09 | 간편 로그인 연동 해제   | P2   | Google 계정을 통한 간편 로그인 연동 해제                          |
| AUTH-10 | Passkey 연동     | P3   | Passkey를 로그인 계정에 연동(등록)                             |
| AUTH-11 | Passkey 이용 로그인 | P3   | Passkey를 이용하여 등록된 계정에 로그인                           |
| AUTH-12 | Passkey 연동 해제  | P3   | 로그인 계정에 등록된 passkey를 제거.  |

**수용 기준:**
- [ ] 이메일 형식 유효성 검사
- [ ] 비밀번호 최소 8자, 영문+숫자+특수문자 조합
- [ ] 중복 이메일 가입 방지
- [ ] 초대코드 유효성 검증 (존재 여부, 만료 여부, 사용 횟수)
- [ ] 회원가입 시 초대코드에 지정된 학원+역할로 자동 멤버십 생성
- [ ] JWT Access Token 유효시간: 1시간
- [ ] Refresh Token 유효시간: 14일 (sliding window 방식, 사용 시 갱신)
- [ ] 비밀번호 찾기: 이메일/SMS 인증 완료 사용자만 자동 재설정, 그 외 관리자 문의 안내
- [ ] Google OAuth: 기존 계정에 연동/해제 가능. 연동된 계정은 Google 로그인으로 접근 가능
- [ ] Passkey: WebAuthn/FIDO2 기반. 기존 계정에 등록/해제 가능. 등록된 Passkey로 로그인 가능

### 3.2 사용자 프로필 (User Profile)

| ID | 기능 | 우선순위 | 설명 |
|----|------|----------|------|
| USR-01 | 프로필 조회 | P0 | 이름, 이메일, 전화번호, 프로필 이미지, 소속 학원 목록 |
| USR-02 | 프로필 수정 | P1 | 이름, 전화번호 수정 |
| USR-03 | 프로필 이미지 업로드 | P1 | JPG, PNG만 허용. 파일 크기 제한 |
| USR-04 | 프로필 이미지 삭제 | P2 | 기본 이미지로 초기화 |

**수용 기준:**
- [ ] 허용 파일 형식: JPG, PNG만
- [ ] 파일 크기 제한: 5MB
- [ ] 업로드 시 원본 저장 + 썸네일 별도 생성
- [ ] 파일 저장소: 로컬 디스크 (추후 AWS S3 전환 가능하도록 저장소 추상화)

### 3.3 학원 관리 (Academy)

| ID | 기능 | 우선순위 | 설명 |
|----|------|----------|------|
| ACD-01 | 학원 생성 | P0 | 시스템 관리자만 가능. 학원명, 설명, 연락처 등. 관리자 1명 지정 |
| ACD-02 | 학원 정보 수정 | P1 | 시스템 관리자 또는 해당 학원 관리자 |
| ACD-03 | 학원 목록 조회 | P0 | 시스템 관리자: 전체 / 일반 사용자: 자신이 소속된 학원 목록 |
| ACD-04 | 학원 상세 조회 | P0 | 학원 소속 멤버만 조회 가능 |
| ACD-05 | 학원 비활성화 | P2 | 시스템 관리자만 가능. 소프트 삭제 |

**수용 기준:**
- [ ] 학원 생성 시 초기 관리자 1명 지정 필수
- [ ] 학원당 관리자는 1명으로 제한
- [ ] 학원 비활성화 시 하위 리소스 접근 차단

### 3.4 멤버십 & 초대코드 (Membership)

| ID | 기능 | 우선순위 | 설명 |
|----|------|----------|------|
| MBR-01 | 초대코드 생성 | P0 | 학원 관리자가 역할(수강생/강사)별 초대코드 생성. 부여할 수강 횟수 설정 |
| MBR-02 | 초대코드 목록 관리 | P1 | 생성된 코드 조회, 비활성화, 삭제 |
| MBR-03 | 초대코드로 학원 가입 | P0 | 회원가입 시 또는 기존 회원이 추가 학원 가입. 멤버십에 수강 횟수 부여 |
| MBR-04 | 멤버 목록 조회 | P0 | 학원 관리자가 소속 멤버 조회 (잔여 횟수 포함) |
| MBR-05 | 멤버 역할 변경 | P1 | 학원 관리자가 멤버 역할 변경 (수강생 ↔ 강사) |
| MBR-06 | 멤버 제거 | P1 | 학원 관리자가 멤버 탈퇴 처리 |
| MBR-07 | 학원 전환 | P0 | 사용자가 소속된 학원 간 전환 (앱 내 컨텍스트 변경) |
| MBR-08 | 수강 횟수 수동 충전 | P1 | 학원 관리자가 특정 멤버의 수강 횟수를 수동으로 추가 |

**수용 기준:**
- [ ] 초대코드 형식: 영숫자 조합 (예: `ABC123`) — 추후 1회용 랜덤 코드로 개선 예정
- [ ] 초대코드에 만료일 설정 가능 (선택)
- [ ] 초대코드 가입 인원: `unlimited = true`이면 비활성화 전까지 여러 명 가입 가능, 아닌 경우 최대 가입 인원 설정
- [ ] 초대코드에 **부여 수강 횟수** 설정: 가입 시 멤버십의 잔여 횟수로 부여
- [ ] 한 학원에 동일 사용자 중복 가입 방지
- [ ] 학원 관리자는 자신을 제거할 수 없음

#### 수강 횟수(크레딧) 규칙
- [ ] 초대코드로 가입 시 → 멤버십에 초대코드에 설정된 수강 횟수 부여
- [ ] 수강 신청 1건 = 잔여 횟수 1 차감
- [ ] 잔여 횟수 0이면 수강 신청 불가 → "관리자에게 문의하세요" 팝업 표시
- [ ] 수강 취소 시 잔여 횟수 1 복구 **단, 수업 시작일 당일 취소 시 횟수 미복구**
- [ ] 학원 관리자가 멤버의 수강 횟수를 수동으로 추가 가능

### 3.5 수업 관리 (Course)

| ID | 기능 | 우선순위 | 설명 |
|----|------|----------|------|
| CRS-01 | 수업 목록 조회 | P0 | 해당 학원의 수업만 표시. 상태별 필터링 |
| CRS-02 | 수업 상세 조회 | P0 | 제목, 설명, 강사, 정원, 현재 등록수, 일정, 상태 표시 |
| CRS-03 | 수업 생성 | P0 | 학원 관리자/강사가 해당 학원에 수업 등록. 수강신청타입(AUTO_APPROVE/MANUAL_APPROVE) 설정 |
| CRS-04 | 수업 수정 | P1 | 수업 정보 수정 (진행중인 수업은 일부 필드 제한) |
| CRS-05 | 수업 상태 변경 | P1 | OPEN → CLOSED, IN_PROGRESS → COMPLETED 등 |
| CRS-06 | 수업 삭제 | P2 | 수강 신청이 없는 수업만 삭제 가능 |
| CRS-07 | 수업 키워드 검색 | P1 | 제목/설명 키워드로 수업 검색 |
| CRS-08 | 수업 요일 필터 | P1 | 특정 요일에 진행되는 수업 필터링 |
| CRS-09 | 달력 수업 보기 | P1 | 달력 UI에서 신청 가능한 수업 일정 확인 |
| CRS-10 | 월별 수업 일정 생성 | P1 | 강사가 월 단위로 수업 일정 생성 |
| CRS-11 | 반복 일정 등록 | P1 | 일정 생성 시 반복 패턴 설정 (예: 매주 월/수/금) |

**수용 기준:**
- [ ] 수업은 반드시 하나의 학원에 종속
- [ ] 수강신청타입 필수 설정: `AUTO_APPROVE`(즉시 완료) / `MANUAL_APPROVE`(승인 필요)
- [ ] 수업 상태에 따른 신청 가능 여부 제어
- [ ] 페이지네이션 지원
- [ ] 수업 스케줄: 강사가 월별 일정 생성, 반복 일정 등록 지원 (예: 매주 월/수/금 반복)
- [ ] 달력 뷰에서 개별 일정 단위로 표시

### 3.6 수강 신청 (Enrollment)

| ID | 기능 | 우선순위 | 설명                                                                         |
|----|------|----------|----------------------------------------------------------------------------|
| ENR-01 | 수강 신청 | P0 | 수강생이 자신이 소속된 학원의 OPEN 수업에 신청. 수업의 수강신청타입에 따라 즉시완료 또는 승인대기 |
| ENR-02 | 내 신청 목록 조회 | P0 | 현재 학원 컨텍스트 내 자신의 수강 신청 내역 + 잔여 횟수 표시 |
| ENR-03 | 수강 신청 승인/거절 | P0 | 강사/학원 관리자가 PENDING 상태 신청 승인 또는 거절 (MANUAL_APPROVE 타입만 해당) |
| ENR-04 | 수강 취소 | P1 | 수강생이 APPROVED/PENDING 상태의 신청 취소. 횟수 복구 조건부 |
| ENR-05 | 수업별 신청 목록 조회 | P1 | 강사/학원 관리자가 특정 수업의 신청 목록 확인 (대기자 포함) |
| ENR-06 | 수강 대기 | P1 | 정원 초과 시 WAITLISTED 상태로 대기열 등록 (횟수 미차감) |
| ENR-07 | 공석 알림 | P1 | 취소 발생 시 대기열 선두 대기자에게 공석 발생 알림 |

**수강신청 타입 (수업 속성):**
- `AUTO_APPROVE`: 정원 내 → 즉시 APPROVED (횟수 즉시 차감)
- `MANUAL_APPROVE`: 정원 내 → PENDING → 강사/관리자 승인 시 APPROVED (승인 시점에 횟수 차감)

**상태 전이:**
```
[정원 내]
  AUTO_APPROVE:   → APPROVED (횟수 차감) → CANCELLED
  MANUAL_APPROVE: → PENDING → APPROVED (횟수 차감) / REJECTED
                              APPROVED → CANCELLED

[정원 초과]
  → WAITLISTED → (공석 발생 시) → AUTO_APPROVE: APPROVED / MANUAL_APPROVE: PENDING
               → CANCELLED (대기 취소, 횟수 미차감)
```

**수용 기준:**
- [ ] 해당 학원 멤버만 수강 신청 가능
- [ ] **잔여 수강 횟수 ≥ 1 이어야 신청 가능** (0이면 "관리자에게 문의하세요" 팝업)
- [ ] **횟수 차감 시점 = 신청 완료(APPROVED) 시점**
  - AUTO_APPROVE: 신청 즉시 차감
  - MANUAL_APPROVE: 강사/관리자 승인 시 차감
  - WAITLISTED: 횟수 미차감 (대기 상태)
- [ ] 동일 수강생이 같은 수업에 중복 신청 불가 (WAITLISTED 포함)
- [ ] 정원 초과 시 WAITLISTED 상태로 대기열 등록 (선착순 관리)
- [ ] 취소 발생 시 대기열 선두 대기자에게 공석 알림 발송
- [ ] 수업의 currentEnrollment 카운트: APPROVED 시 +1, CANCELLED 시 -1 (동시성 제어 필요)
- [ ] **취소 시 횟수 복구 규칙:**
  - APPROVED 상태 + 수업 시작일 이전 취소: 잔여 횟수 1 복구
  - APPROVED 상태 + 수업 시작일 당일 취소: 취소는 되지만 횟수 미복구
  - PENDING/WAITLISTED 상태 취소: 횟수 차감 전이므로 복구 불필요

### 3.7 게시판 (Board)

| ID | 기능 | 우선순위 | 설명 |
|----|------|----------|------|
| BRD-01 | 글 목록 조회 | P0 | 해당 학원의 게시글만 표시. 고정글 상단 노출 |
| BRD-02 | 글 상세 조회 | P0 | 내용 표시, 조회수 증가 (사용자 기반 중복 방지, 동시성 고려) |
| BRD-03 | 글 작성 | P0 | 학원 소속 멤버만 작성 가능. 첨부파일 포함 가능 |
| BRD-04 | 글 수정 | P1 | 본인 작성 글만 수정 가능 |
| BRD-05 | 글 삭제 | P1 | 본인 또는 학원 관리자 삭제 가능 |
| BRD-06 | 글 고정/해제 | P2 | 학원 관리자만 가능 |
| BRD-07 | 검색 | P2 | 제목/내용 키워드 검색 |
| BRD-08 | 댓글 작성 | P0 | 학원 소속 멤버만 작성 가능 |
| BRD-09 | 대댓글 작성 | P1 | 댓글에 대한 답글 (1depth까지) |
| BRD-10 | 댓글 수정/삭제 | P1 | 본인 작성 댓글만 수정/삭제 가능 |
| BRD-11 | 첨부파일 다운로드 | P0 | 학원 소속 멤버만 다운로드 가능 |

**수용 기준:**
- [ ] 게시글은 반드시 하나의 학원에 종속
- [ ] 고정글은 항상 목록 상단에 표시
- [ ] 조회수 중복 방지: 사용자 기반 (동일 사용자 재조회 시 카운트 증가 안 함)
- [ ] 조회수 동시성: 원자적 증가 처리
- [ ] 대댓글은 1depth까지만 허용 (대댓글의 대댓글은 불가)
- [ ] 첨부파일 허용 형식: 이미지(JPG, PNG, GIF) + 문서(PDF, DOC, DOCX, HWP, XLS, XLSX)
- [ ] 첨부파일 크기 제한: 10MB (파일당)
- [ ] 게시글당 첨부파일 최대 개수: 5개

### 3.8 공지사항 (Notice)

| ID | 기능 | 우선순위 | 설명 |
|----|------|----------|------|
| NTC-01 | 공지사항 목록 조회 | P0 | 해당 학원의 공지만 표시. 중요 공지 상단 노출 |
| NTC-02 | 공지사항 상세 조회 | P0 | 내용 표시, 조회수 증가 (사용자 기반 중복 방지) |
| NTC-03 | 공지사항 작성 | P0 | 학원 관리자만 가능 |
| NTC-04 | 공지사항 수정 | P1 | 학원 관리자만 가능 |
| NTC-05 | 공지사항 삭제 | P1 | 학원 관리자만 가능 |

**수용 기준:**
- [ ] 공지사항은 반드시 하나의 학원에 종속
- [ ] 중요 공지는 항상 목록 상단에 표시
- [ ] 학원 관리자 권한 검증 필수
- [ ] 조회수 중복 방지: 사용자 기반

### 3.9 푸시 알림 (Push Notification)

| ID | 기능 | 우선순위 | 설명 |
|----|------|----------|------|
| PUSH-01 | 수강 신청 알림 (강사) | P1 | 수강생이 수강 신청 시 해당 수업 강사에게 푸시 알림 |
| PUSH-02 | 수강 신청 완료 알림 (학생) | P1 | 수강 신청 접수 완료 시 학생에게 확인 알림 |
| PUSH-03 | 수강 승인/거절 알림 (학생) | P1 | 강사/관리자가 승인 또는 거절 시 학생에게 알림 |
| PUSH-04 | 수강 취소 알림 (강사) | P1 | 학생이 수강 취소 시 해당 수업 강사에게 알림 |
| PUSH-05 | 수강 취소 완료 알림 (학생) | P1 | 취소 접수 완료 시 학생에게 확인 알림 |
| PUSH-06 | 공지사항 등록 알림 | P1 | 새 공지사항 등록 시 해당 학원 전체 멤버에게 알림 |
| PUSH-10 | 공석 발생 알림 (대기자) | P1 | 수강 취소로 공석 발생 시 대기열 선두 대기자에게 알림 |
| PUSH-07 | 알림 수신 설정 | P1 | 사용자가 알림 종류별 on/off 토글 설정 |
| PUSH-08 | 인앱 알림 목록 | P1 | 알림 이력 조회, 읽음/안읽음 상태 관리 |
| PUSH-09 | 알림 읽음 처리 | P1 | 개별/전체 읽음 처리 |

**수용 기준:**
- [ ] 푸시 알림 인프라: FCM (Firebase Cloud Messaging) — Android/iOS/웹 통합
- [ ] 사용자별 알림 수신 설정 지원 (알림 종류별 on/off 토글)
- [ ] 인앱 알림 목록 지원: 알림 이력 DB 저장 + 앱 내 알림 목록 조회
- [ ] 알림 읽음/안읽음 상태 관리

### 3.10 학원 관리자 대시보드 (Dashboard)

| ID | 기능 | 우선순위 | 설명 |
|----|------|----------|------|
| DSH-01 | 강사별 수강생 현황 | P2 | 각 강사가 담당하는 수업별 수강생 수, 승인/대기 현황 |
| DSH-02 | 수강생별 수업 등록 현황 | P2 | 각 수강생이 등록한 수업 목록과 상태 |
| DSH-03 | 학원 요약 통계 | P2 | 총 멤버 수, 수업 수, 활성 수강 신청 수 등 |

**수용 기준:**
- [ ] 학원 관리자만 접근 가능
- [ ] 실시간 조회 방식 (요청 시 즉시 집계 쿼리 실행)

---

## 4. 권한 매트릭스

| 기능 | SYSTEM_ADMIN | ACADEMY_ADMIN | INSTRUCTOR | STUDENT |
|------|:---:|:---:|:---:|:---:|
| 학원 생성 | ✅ | - | - | - |
| 학원 정보 수정 | ✅ | ✅ (자기 학원) | - | - |
| 초대코드 관리 | ✅ | ✅ (자기 학원) | - | - |
| 멤버 관리 | ✅ | ✅ (자기 학원) | - | - |
| 수업 생성 | - | ✅ | ✅ | - |
| 수업 수정/삭제 | - | ✅ | ✅ (본인 수업) | - |
| 수강 횟수 충전 | ✅ | ✅ (자기 학원) | - | - |
| 수강 신청 | - | - | - | ✅ |
| 수강 승인/거절 (MANUAL_APPROVE) | - | ✅ | ✅ (본인 수업) | - |
| 공지사항 작성 | - | ✅ | - | - |
| 게시판 글 작성 | - | ✅ | ✅ | ✅ |
| 게시판 댓글 작성 | - | ✅ | ✅ | ✅ |
| 게시판 글 삭제 (타인) | - | ✅ | - | - |
| 수업 일정 생성 | - | ✅ | ✅ (본인 수업) | - |
| 대시보드 조회 | ✅ | ✅ (자기 학원) | - | - |
| 프로필 이미지 관리 | ✅ | ✅ | ✅ | ✅ |
| 알림 수신 설정 | ✅ | ✅ | ✅ | ✅ |

---

## 5. API 경로 설계 (안)

학원 컨텍스트가 필요한 API는 `/api/academies/{academyId}/` 하위에 배치:

```
# 인증 (글로벌)
POST   /api/auth/signup
POST   /api/auth/login
POST   /api/auth/refresh
POST   /api/auth/join-academy          # 기존 회원이 초대코드로 학원 가입
POST   /api/auth/forgot-password       # 비밀번호 찾기 요청
POST   /api/auth/reset-password        # 비밀번호 재설정
POST   /api/auth/google                # Google 간편 로그인
POST   /api/auth/google/link           # Google 계정 연동
DELETE /api/auth/google/link           # Google 계정 연동 해제
POST   /api/auth/passkey/register      # Passkey 등록 (연동)
POST   /api/auth/passkey/authenticate  # Passkey 인증 (로그인)
DELETE /api/auth/passkey               # Passkey 연동 해제

# 사용자 (글로벌)
GET    /api/users/me                    # 내 정보 + 소속 학원 목록
PUT    /api/users/me                    # 내 정보 수정
POST   /api/users/me/profile-image      # 프로필 이미지 업로드
DELETE /api/users/me/profile-image      # 프로필 이미지 삭제

# 알림 (글로벌)
GET    /api/notifications               # 인앱 알림 목록
PUT    /api/notifications/{id}/read     # 알림 읽음 처리
PUT    /api/notifications/read-all      # 전체 읽음 처리
GET    /api/notification-settings       # 알림 수신 설정 조회
PUT    /api/notification-settings       # 알림 수신 설정 변경

# 학원 (시스템 관리자)
POST   /api/academies                   # 학원 생성
GET    /api/academies                   # 내 학원 목록 (시스템 관리자: 전체)

# 학원 내 리소스
GET    /api/academies/{id}              # 학원 상세
POST   /api/academies/{id}/invite-codes # 초대코드 생성
GET    /api/academies/{id}/invite-codes # 초대코드 목록
GET    /api/academies/{id}/members      # 멤버 목록 (잔여 횟수 포함)
PUT    /api/academies/{id}/members/{memberId}/credits  # 수강 횟수 수동 충전
GET    /api/academies/{id}/dashboard    # 대시보드 통계

GET    /api/academies/{id}/courses      # 수업 목록 (검색/요일 필터 query param)
POST   /api/academies/{id}/courses      # 수업 생성
GET    /api/academies/{id}/courses/{courseId}
GET    /api/academies/{id}/courses/calendar  # 달력 수업 보기 (월별 일정)
POST   /api/academies/{id}/courses/{courseId}/schedules  # 수업 일정 생성 (반복 포함)
POST   /api/academies/{id}/courses/{courseId}/enrollments  # 수강 신청
GET    /api/academies/{id}/courses/{courseId}/enrollments  # 수업별 신청 목록

GET    /api/academies/{id}/board        # 게시글 목록
POST   /api/academies/{id}/board        # 게시글 작성 (첨부파일 포함)
GET    /api/academies/{id}/board/{postId}
POST   /api/academies/{id}/board/{postId}/comments  # 댓글/대댓글 작성

GET    /api/academies/{id}/notices      # 공지 목록
POST   /api/academies/{id}/notices      # 공지 작성
```

---

## 6. 비기능 요구사항

### 6.1 보안
| ID | 요구사항 | 상태 |
|----|----------|------|
| SEC-01 | JWT 기반 인증/인가 (Access 1h, Refresh 14d sliding) | 미구현 |
| SEC-02 | 비밀번호 BCrypt 암호화 | 미구현 |
| SEC-03 | 학원별 역할 기반 접근 제어 (RBAC) | 미구현 |
| SEC-04 | 학원 간 데이터 격리 (멤버만 접근) | 미구현 |
| SEC-05 | CORS 정책 운영환경 제한 | 미구현 (현재 전체 허용) |
| SEC-06 | 파일 업로드 보안 (형식/크기 제한, MIME 타입 검증) | 미구현 |
| SEC-07 | Google OAuth 2.0 연동 | 미구현 |
| SEC-08 | Passkey (WebAuthn/FIDO2) 인증 | 미구현 |

### 6.2 성능
| ID | 요구사항 | 상태 |
|----|----------|------|
| PERF-01 | API 응답시간 200ms 이내 | 미측정 |
| PERF-02 | 페이지네이션 (기본 20건) | 설계 완료 |
| PERF-03 | 조회수 동시성 제어 (원자적 증가) | 미구현 |
| PERF-04 | 수강 정원 동시성 제어 (비관적/낙관적 락) | 미구현 |

### 6.3 데이터
| ID | 요구사항 | 상태 |
|----|----------|------|
| DATA-01 | Flyway DB 마이그레이션 | V1 완료 (스키마 변경 필요) |
| DATA-02 | 생성/수정 시각 자동 기록 | 구현 완료 (BaseEntity) |
| DATA-03 | 파일 저장소 구성 (로컬, S3 전환 가능 추상화) | 미구현 |
| DATA-04 | 이메일/SMS 인증 서비스 연동 (외부 서비스 추상화) | 미구현 |

---

## 7. 현재 구현 상태 & 필요 변경

### 7.1 DB 스키마 변경 필요
기존 스키마(V1)는 단일 학원 기준. 멀티 학원 지원을 위해 V2 마이그레이션 필요:

- **신규 테이블**: `academies`, `academy_members` (role + remaining_credits), `invite_codes` (granted_credits), `course_schedules`, `board_comments`, `board_attachments`, `post_views`, `notice_views`, `notifications`, `notification_settings`, `credit_histories` (횟수 변동 이력)
- **기존 테이블 변경**: `courses`, `board_posts`, `notices`에 `academy_id` FK 추가
- **`users` 테이블 변경**: `role` 컬럼 제거 (역할은 academy_members로 이동), `profile_image_url`, `thumbnail_image_url` 추가
- **`courses` 테이블 변경**: 스케줄은 별도 `course_schedules` 테이블로 분리 (반복 일정 지원), `enrollment_type` 컬럼 추가 (AUTO_APPROVE/MANUAL_APPROVE)
- **`enrollments` 테이블**: student가 해당 학원 멤버인지 검증 로직 추가, `WAITLISTED` 상태 추가, 대기 순번 관리
- **`users` 테이블**: `google_id`, `passkey_credential_id` 등 간편 인증 연동 필드 추가

### 7.2 Backend
| 레이어 | 상태 | 비고 |
|--------|------|------|
| Entity | 🔶 변경 필요 | Academy, AcademyMember, InviteCode, CourseSchedule, BoardComment, BoardAttachment, Notification, NotificationSetting 등 추가 |
| Repository | 🔶 변경 필요 | academyId 기반 쿼리 추가 |
| Service | ❌ 미구현 | 비즈니스 로직 레이어 필요 |
| Controller | ❌ 미구현 | REST API 엔드포인트 필요 |
| Security | ❌ 미구현 | JWT + 학원별 RBAC 필요 |
| DTO | ❌ 미구현 | Request/Response DTO 필요 |
| Push | ❌ 미구현 | FCM 푸시 알림 인프라 필요 |
| File | ❌ 미구현 | 파일 업로드/다운로드 인프라 필요 (저장소 추상화) |
| External | ❌ 미구현 | 이메일/SMS 외부 서비스 연동 (추상화) |

### 7.3 Frontend
| 레이어 | 상태 | 비고 |
|--------|------|------|
| 라우팅 | 🔶 변경 필요 | 학원 선택/전환 플로우 추가 |
| 테마 | ✅ 완료 | Material 3 라이트/다크 테마 |
| 네트워크 | 🔶 변경 필요 | API 경로에 academyId 반영 |
| 화면 | 🔶 변경 필요 | 학원 선택, 초대코드 입력, 달력, 대시보드 화면 추가 |
| 모델 | ❌ 미구현 | Freezed 데이터 모델 필요 |
| 상태관리 | ❌ 미구현 | 현재 학원 컨텍스트 상태 관리 필요 |
| API 연동 | ❌ 미구현 | Retrofit 서비스 필요 |
| Push | ❌ 미구현 | 푸시 알림 수신 처리 필요 |

---

## 8. 결정 사항 요약

| # | 항목 | 결정 |
|---|------|------|
| 1 | JWT Access Token | 1시간 |
| 2 | Refresh Token | 14일, sliding window 방식 |
| 3 | 프로필 이미지 | 지원. JPG/PNG만, 최대 5MB. 원본 저장 + 썸네일 별도 생성 |
| 4 | 파일 저장소 | 로컬 디스크 (추후 AWS S3 전환 가능하도록 저장소 추상화) |
| 5 | 게시판 첨부파일 | 지원. 이미지+문서(PDF, DOC, DOCX, HWP, XLS, XLSX). 파일당 10MB, 게시글당 최대 5개 |
| 6 | 게시판 댓글 | 댓글 + 대댓글(1depth) 지원 |
| 7 | 푸시 알림 | FCM. 수강 신청/취소 시 강사+학생 알림, 공지 등록 시 학원 전체 알림 |
| 8 | 알림 수신 설정 | 지원. 사용자별 알림 종류별 on/off 토글 |
| 9 | 인앱 알림 목록 | 지원. 알림 이력 DB 저장, 읽음/안읽음 관리 |
| 10 | 조회수 중복 방지 | 사용자 기반, 동시성 고려 (원자적 증가) |
| 11 | 수업 검색 | 키워드 검색, 요일 필터, 달력 UI에서 수업 보기 |
| 12 | 수업 스케줄 | 강사가 월별 일정 생성. 반복 일정 등록 지원 (예: 매주 월/수/금) |
| 13 | 비밀번호 찾기 | 이메일/SMS 인증 완료자 → 자동 재설정, 미인증 → 관리자 문의 |
| 14 | 이메일/SMS 서비스 | 외부 서비스 연동 (추상화하여 구현체 교체 가능) |
| 15 | 학원 관리자 대시보드 | 실시간 조회. 강사별 수강생 현황, 수강생별 수업 현황, 요약 통계 |
| 16 | 초대코드 가입 인원 | `unlimited=true` 시 비활성화 전까지 여러 명 가입 가능 (추후 1회용 랜덤 코드로 개선 예정) |
| 17 | 수강 횟수(크레딧) | 초대코드에 부여 횟수 설정 → 가입 시 멤버십에 부여. 신청 시 1 차감, 취소 시 1 복구 (수업 시작일 당일 취소는 미복구) |
| 18 | 횟수 소진 시 | 수강 신청 불가 + "관리자에게 문의하세요" 팝업. 관리자가 수동 충전 가능 |
| 19 | 수강신청 타입 | 수업별 설정: AUTO_APPROVE(즉시 완료) / MANUAL_APPROVE(승인 필요) |
| 20 | 수강 대기열 | 정원 초과 시 WAITLISTED. 취소 발생 시 대기자에게 공석 알림 |
| 21 | 간편 로그인 | Google OAuth 2.0 (P2) |
| 22 | Passkey | WebAuthn/FIDO2 기반 (P3) |
| 23 | 학원당 관리자 수 | 1명 |

---

## 9. 구현 우선순위 로드맵 (제안)

### Phase 1: 핵심 인프라
1. DB 스키마 V2 마이그레이션 (Academy, AcademyMember, InviteCode, CourseSchedule 등)
2. 파일 저장소 추상화 레이어 구축 (로컬 구현체, S3 전환 가능)
3. Backend Security 설정 (JWT 인증/인가 + 학원별 RBAC)
4. User + Academy + Membership Service/Controller
5. Frontend 인증 플로우 (회원가입, 로그인, 학원 선택/전환)

### Phase 2: 핵심 기능
6. 초대코드 관리 (생성, 검증, 학원 가입 + 수강 횟수 부여)
7. Course Service/Controller (학원 내 CRUD + 검색/요일 필터)
8. 수업 일정 관리 (월별 일정 생성, 반복 일정 등록)
9. Enrollment Service/Controller (신청/승인/거절 + 횟수 차감/복구 + 동시성 제어)
10. Frontend 수업 목록/상세/수강 신청/달력 화면

### Phase 3: 커뮤니티 & 파일
11. Board Service/Controller (학원 내 CRUD + 댓글/대댓글 + 첨부파일)
12. Notice Service/Controller (학원 내 CRUD)
13. 프로필 이미지 업로드 (원본 + 썸네일)
14. Frontend 게시판/공지사항 화면

### Phase 4: 알림 & 통계
15. FCM 푸시 알림 인프라 구축
16. 인앱 알림 목록 + 알림 수신 설정
17. 학원 관리자 대시보드 (실시간 통계)
18. 이메일/SMS 외부 서비스 연동 (추상화)
19. 비밀번호 찾기 플로우

### Phase 5: 부가 기능
20. 멤버 관리 (역할 변경, 제거)
21. 수업 수정/삭제, 수강 취소
22. 게시판 수정/삭제, 검색
23. 프로필 관리, 비밀번호 변경

### Phase 6: 간편 인증 (P2-P3)
24. Google OAuth 2.0 연동/해제 + 간편 로그인
25. Passkey (WebAuthn/FIDO2) 등록/해제 + 인증 로그인

---

*이 문서는 프로젝트 진행에 따라 지속적으로 업데이트됩니다.*
