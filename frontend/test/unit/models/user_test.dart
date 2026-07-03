import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/auth/domain/models/token_pair.dart';
import 'package:healthier/features/auth/domain/models/user.dart';

void main() {
  group('User', () {
    test('전체 필드 JSON을 파싱한다', () {
      final user = User.fromJson({
        'id': 1,
        'email': 'user@example.com',
        'name': '홍길동',
        'phone': '010-1234-5678',
        'profileImageUrl': 'http://img',
        'thumbnailImageUrl': 'http://thumb',
        'academies': [
          {
            'academyId': 10,
            'academyName': '테스트학원',
            'role': 'STUDENT',
            'remainingCredits': 5,
          },
        ],
      });

      expect(user.id, 1);
      expect(user.email, 'user@example.com');
      expect(user.name, '홍길동');
      expect(user.phone, '010-1234-5678');
      expect(user.academies, hasLength(1));
      expect(user.academies.first.academyName, '테스트학원');
      expect(user.academies.first.remainingCredits, 5);
    });

    test('academies가 없으면 빈 리스트로 파싱한다', () {
      final user = User.fromJson({
        'id': 1,
        'email': 'user@example.com',
        'name': '홍길동',
      });

      expect(user.academies, isEmpty);
      expect(user.phone, isNull);
    });

    test('toJson 후 fromJson 하면 동일한 객체가 된다', () {
      const user = User(
        id: 1,
        email: 'user@example.com',
        name: '홍길동',
        academies: [
          UserAcademy(
            academyId: 10,
            academyName: '테스트학원',
            role: 'STUDENT',
            remainingCredits: 3,
          ),
        ],
      );

      expect(User.fromJson(user.toJson()), user);
    });

    test('copyWith로 일부 필드만 변경할 수 있다', () {
      const user = User(id: 1, email: 'a@b.com', name: '홍길동');
      final updated = user.copyWith(name: '김철수');

      expect(updated.name, '김철수');
      expect(updated.email, 'a@b.com');
    });
  });

  group('TokenPair', () {
    test('JSON을 파싱한다', () {
      final pair = TokenPair.fromJson({
        'accessToken': 'access',
        'refreshToken': 'refresh',
      });

      expect(pair.accessToken, 'access');
      expect(pair.refreshToken, 'refresh');
    });
  });
}
