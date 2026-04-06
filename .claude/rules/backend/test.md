---
paths:
  - "backend/**"
---

# Backend 테스트 가이드 (JUnit 5)

## 프레임워크
- **JUnit 5** + **AssertJ** (단언)
- **Mockito** (단위 테스트 목킹)
- **Spring Boot Test** (통합 테스트)
- 테스트 프로필: `test` (H2, create-drop, Flyway 비활성화)

## 테스트 분류
| 분류 | 대상 | 어노테이션 |
|------|------|-----------|
| 단위 테스트 | Service, Util | `@ExtendWith(MockitoExtension::class)` |
| 리포지토리 테스트 | Repository | `@DataJpaTest` |
| 통합 테스트 | Controller (API) | `@SpringBootTest` + `@AutoConfigureMockMvc` |

## 실행 명령어
```bash
cd backend
./gradlew test                          # 전체 테스트
./gradlew test --tests "*.UserServiceTest"  # 특정 클래스
./gradlew jacocoTestReport              # 커버리지 리포트
```

## 작성 규칙
- Given-When-Then 패턴 사용
- 테스트 메서드명: 백틱(`) 한글 서술 (예: `` `유효하지 않은 이메일로 가입 시 예외 발생`() ``)
- 각 테스트는 독립적으로 실행 가능해야 함
- DB 테스트는 `@Transactional`로 롤백 보장
