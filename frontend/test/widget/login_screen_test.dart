import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/auth/data/auth_repository.dart';
import 'package:healthier/features/auth/domain/models/user.dart';
import 'package:healthier/features/auth/presentation/screens/login_screen.dart';

class FakeAuthRepository implements AuthRepository {
  bool shouldFail = false;
  String? lastLoginEmail;

  @override
  Future<User> login({required String email, required String password}) async {
    lastLoginEmail = email;
    if (shouldFail) throw Exception('이메일 또는 비밀번호가 올바르지 않습니다');
    return const User(id: 1, email: 'user@example.com', name: '홍길동');
  }

  @override
  Future<User> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? inviteCode,
  }) async =>
      const User(id: 1, email: 'user@example.com', name: '홍길동');

  @override
  Future<User> getMe() async =>
      const User(id: 1, email: 'user@example.com', name: '홍길동');

  @override
  Future<bool> hasValidSession() async => false;

  @override
  Future<void> logout() async {}

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

  setUp(() {
    repository = FakeAuthRepository();
  });

  Future<void> pumpLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
  }

  group('LoginScreen', () {
    testWidgets('타이틀·입력 필드·로그인 버튼을 표시한다', (tester) async {
      await pumpLoginScreen(tester);

      expect(find.text('Healthier'), findsOneWidget);
      expect(find.text('이메일'), findsOneWidget);
      expect(find.text('비밀번호'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, '로그인'), findsOneWidget);
    });

    testWidgets('빈 입력으로 로그인하면 검증 오류를 표시하고 로그인하지 않는다', (tester) async {
      await pumpLoginScreen(tester);

      await tester.tap(find.widgetWithText(ElevatedButton, '로그인'));
      await tester.pump();

      expect(find.text('이메일을 입력해주세요'), findsOneWidget);
      expect(find.text('비밀번호를 입력해주세요'), findsOneWidget);
      expect(repository.lastLoginEmail, isNull);
    });

    testWidgets('잘못된 이메일 형식이면 형식 오류를 표시한다', (tester) async {
      await pumpLoginScreen(tester);

      await tester.enterText(find.byType(TextFormField).first, 'invalid');
      await tester.tap(find.widgetWithText(ElevatedButton, '로그인'));
      await tester.pump();

      expect(find.text('올바른 이메일 형식이 아닙니다'), findsOneWidget);
    });

    testWidgets('유효한 입력으로 로그인하면 저장소 로그인을 호출한다', (tester) async {
      await pumpLoginScreen(tester);

      await tester.enterText(
        find.byType(TextFormField).first,
        'user@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'abcd123!');
      await tester.tap(find.widgetWithText(ElevatedButton, '로그인'));
      await tester.pumpAndSettle();

      expect(repository.lastLoginEmail, 'user@example.com');
    });

    testWidgets('로그인에 실패하면 스낵바로 오류를 표시한다', (tester) async {
      repository.shouldFail = true;
      await pumpLoginScreen(tester);

      await tester.enterText(
        find.byType(TextFormField).first,
        'user@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'wrong123!');
      await tester.tap(find.widgetWithText(ElevatedButton, '로그인'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.textContaining('이메일 또는 비밀번호가 올바르지 않습니다'),
        findsOneWidget,
      );
    });

    testWidgets('비밀번호 표시 아이콘을 누르면 마스킹이 토글된다', (tester) async {
      await pumpLoginScreen(tester);

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
