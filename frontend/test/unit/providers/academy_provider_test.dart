import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/academy/domain/models/academy.dart';
import 'package:healthier/features/academy/presentation/providers/academy_provider.dart';
import 'package:healthier/features/auth/domain/models/user.dart';

void main() {
  late ProviderContainer container;

  const academy = Academy(id: 1, name: '헬시어짐');
  const membership = UserAcademy(
    academyId: 1,
    academyName: '헬시어짐',
    role: 'STUDENT',
    remainingCredits: 5,
  );

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  group('CurrentAcademyNotifier', () {
    test('초기 상태는 학원이 선택되지 않은 상태다', () {
      final state = container.read(currentAcademyProvider);

      expect(state.isSelected, isFalse);
      expect(state.academy, isNull);
    });

    test('select 하면 학원·역할·잔여 횟수가 설정된다', () {
      container
          .read(currentAcademyProvider.notifier)
          .select(academy, membership);

      final state = container.read(currentAcademyProvider);
      expect(state.isSelected, isTrue);
      expect(state.academy?.name, '헬시어짐');
      expect(state.role, 'STUDENT');
      expect(state.remainingCredits, 5);
    });

    test('selectFromUserAcademy 하면 UserAcademy 정보로 학원이 구성된다', () {
      container
          .read(currentAcademyProvider.notifier)
          .selectFromUserAcademy(membership);

      final state = container.read(currentAcademyProvider);
      expect(state.academy?.id, 1);
      expect(state.academy?.name, '헬시어짐');
      expect(state.remainingCredits, 5);
    });

    test('clear 하면 선택이 해제된다', () {
      final notifier = container.read(currentAcademyProvider.notifier);
      notifier.select(academy, membership);

      notifier.clear();

      expect(container.read(currentAcademyProvider).isSelected, isFalse);
    });
  });
}
