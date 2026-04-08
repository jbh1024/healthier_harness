import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/domain/models/user.dart';
import '../../data/academy_repository.dart';
import '../../domain/models/academy.dart';

// 현재 선택된 학원
class CurrentAcademyState {
  final Academy? academy;
  final String? role;
  final int? remainingCredits;

  const CurrentAcademyState({
    this.academy,
    this.role,
    this.remainingCredits,
  });

  bool get isSelected => academy != null;
}

class CurrentAcademyNotifier extends StateNotifier<CurrentAcademyState> {
  CurrentAcademyNotifier() : super(const CurrentAcademyState());

  void select(Academy academy, UserAcademy membership) {
    state = CurrentAcademyState(
      academy: academy,
      role: membership.role,
      remainingCredits: membership.remainingCredits,
    );
  }

  void selectFromUserAcademy(UserAcademy userAcademy) {
    state = CurrentAcademyState(
      academy: Academy(
        id: userAcademy.academyId,
        name: userAcademy.academyName,
      ),
      role: userAcademy.role,
      remainingCredits: userAcademy.remainingCredits,
    );
  }

  void clear() {
    state = const CurrentAcademyState();
  }
}

final currentAcademyProvider =
    StateNotifierProvider<CurrentAcademyNotifier, CurrentAcademyState>((ref) {
  return CurrentAcademyNotifier();
});

// 학원 목록
final academyListProvider = FutureProvider<List<Academy>>((ref) async {
  final repository = ref.read(academyRepositoryProvider);
  return repository.getMyAcademies();
});
