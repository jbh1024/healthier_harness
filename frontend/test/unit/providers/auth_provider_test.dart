import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/auth/data/auth_repository.dart';
import 'package:healthier/features/auth/domain/models/user.dart';
import 'package:healthier/features/auth/presentation/providers/auth_provider.dart';

class FakeAuthRepository implements AuthRepository {
  bool hasSession = false;
  bool shouldFail = false;
  bool logoutCalled = false;

  static const testUser = User(id: 1, email: 'user@example.com', name: '홍길동');

  @override
  Future<bool> hasValidSession() async => hasSession;

  @override
  Future<User> getMe() async {
    if (shouldFail) throw Exception('세션 만료');
    return testUser;
  }

  @override
  Future<User> login({required String email, required String password}) async {
    if (shouldFail) throw Exception('이메일 또는 비밀번호가 올바르지 않습니다');
    return testUser;
  }

  @override
  Future<User> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? inviteCode,
  }) async {
    if (shouldFail) throw Exception('이미 사용 중인 이메일입니다');
    return testUser;
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }

  @override
  Future<void> requestPasswordReset(String email) async {}

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {}
}

void main() {
  late FakeAuthRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
  });

  group('AuthNotifier.checkSession', () {
    test('유효한 세션이 있으면 authenticated 상태가 된다', () async {
      repository.hasSession = true;

      await container.read(authProvider.notifier).checkSession();

      final state = container.read(authProvider);
      expect(state.status, AuthStatus.authenticated);
      expect(state.user, FakeAuthRepository.testUser);
    });

    test('세션이 없으면 unauthenticated 상태가 된다', () async {
      repository.hasSession = false;

      await container.read(authProvider.notifier).checkSession();

      expect(container.read(authProvider).status, AuthStatus.unauthenticated);
    });

    test('세션은 있지만 사용자 조회에 실패하면 unauthenticated 상태가 된다', () async {
      repository.hasSession = true;
      repository.shouldFail = true;

      await container.read(authProvider.notifier).checkSession();

      expect(container.read(authProvider).status, AuthStatus.unauthenticated);
    });
  });

  group('AuthNotifier.login', () {
    test('성공하면 authenticated 상태와 사용자 정보를 갖는다', () async {
      await container
          .read(authProvider.notifier)
          .login(email: 'user@example.com', password: 'abcd123!');

      final state = container.read(authProvider);
      expect(state.status, AuthStatus.authenticated);
      expect(state.user?.email, 'user@example.com');
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('실패하면 error가 설정되고 인증되지 않는다', () async {
      repository.shouldFail = true;

      await container
          .read(authProvider.notifier)
          .login(email: 'user@example.com', password: 'wrong');

      final state = container.read(authProvider);
      expect(state.status, isNot(AuthStatus.authenticated));
      expect(state.isLoading, isFalse);
      expect(state.error, contains('이메일 또는 비밀번호'));
    });
  });

  group('AuthNotifier.signup', () {
    test('성공하면 authenticated 상태가 된다', () async {
      await container.read(authProvider.notifier).signup(
            email: 'user@example.com',
            password: 'abcd123!',
            name: '홍길동',
          );

      expect(container.read(authProvider).status, AuthStatus.authenticated);
    });

    test('실패하면 error가 설정된다', () async {
      repository.shouldFail = true;

      await container.read(authProvider.notifier).signup(
            email: 'dup@example.com',
            password: 'abcd123!',
            name: '홍길동',
          );

      expect(container.read(authProvider).error, contains('이미 사용 중인 이메일'));
    });
  });

  group('AuthNotifier.logout', () {
    test('저장소 로그아웃을 호출하고 unauthenticated 상태가 된다', () async {
      await container
          .read(authProvider.notifier)
          .login(email: 'user@example.com', password: 'abcd123!');

      await container.read(authProvider.notifier).logout();

      expect(repository.logoutCalled, isTrue);
      final state = container.read(authProvider);
      expect(state.status, AuthStatus.unauthenticated);
      expect(state.user, isNull);
    });
  });

  group('AuthNotifier.refreshUser', () {
    test('성공하면 사용자 정보를 갱신한다', () async {
      await container.read(authProvider.notifier).refreshUser();

      expect(container.read(authProvider).user, FakeAuthRepository.testUser);
    });

    test('실패해도 기존 상태를 유지한다', () async {
      await container
          .read(authProvider.notifier)
          .login(email: 'user@example.com', password: 'abcd123!');
      repository.shouldFail = true;

      await container.read(authProvider.notifier).refreshUser();

      final state = container.read(authProvider);
      expect(state.status, AuthStatus.authenticated);
      expect(state.user, FakeAuthRepository.testUser);
    });
  });
}
