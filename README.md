# Healthier - 학원 수강 신청 멀티 플랫폼 앱.

## 기술 스택

| 구분 | 기술 |
|------|------|
| **Backend** | Kotlin, Spring Boot 3, Spring Data JPA, Spring Security |
| **Database** | MySQL 8.0, Flyway (마이그레이션) |
| **Frontend** | Flutter (iOS, Android, Windows, macOS, Linux) |
| **상태관리** | Riverpod |
| **API 문서** | SpringDoc OpenAPI (Swagger) |
| **CI/CD** | GitHub Actions |
| **인프라** | Docker Compose |

## 시작하기

### 사전 요구사항

- **Backend**: JDK 21, Gradle 8.10+
- **Frontend**: Flutter SDK 3.24+
- **Database**: Docker (또는 로컬 MySQL 8.0)

### 1. DB 실행

```bash
docker-compose up -d mysql
```

### 2. Backend 실행

```bash
cd backend
./gradlew bootRun --args='--spring.profiles.active=dev'
```

API 서버: http://localhost:8080/api
Swagger UI: http://localhost:8080/api/swagger-ui.html

### 3. Frontend 실행

```bash
cd frontend
flutter pub get
flutter run          # 현재 연결된 디바이스
flutter run -d chrome    # 웹
flutter run -d windows   # 윈도우 데스크톱
flutter run -d macos     # macOS 데스크톱
```