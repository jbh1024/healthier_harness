import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/academy/domain/models/academy.dart';

void main() {
  group('Academy', () {
    test('JSON을 파싱한다', () {
      final academy = Academy.fromJson({
        'id': 1,
        'name': '헬시어짐',
        'description': '설명',
        'contactInfo': '02-1234-5678',
        'isActive': false,
      });

      expect(academy.name, '헬시어짐');
      expect(academy.isActive, isFalse);
    });

    test('isActive가 없으면 기본값 true로 파싱한다', () {
      final academy = Academy.fromJson({'id': 1, 'name': '헬시어짐'});

      expect(academy.isActive, isTrue);
      expect(academy.description, isNull);
    });
  });
}
