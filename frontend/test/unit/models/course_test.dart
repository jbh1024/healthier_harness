import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/course/domain/models/course.dart';

void main() {
  Course buildCourse({int maxCapacity = 10, int currentEnrollment = 0}) {
    return Course(
      id: 1,
      title: '요가 클래스',
      instructorName: '김강사',
      maxCapacity: maxCapacity,
      currentEnrollment: currentEnrollment,
      enrollmentType: 'AUTO_APPROVE',
      status: 'OPEN',
    );
  }

  group('Course', () {
    test('JSON을 파싱한다', () {
      final course = Course.fromJson({
        'id': 1,
        'title': '요가 클래스',
        'description': '초보 환영',
        'instructorName': '김강사',
        'maxCapacity': 10,
        'currentEnrollment': 3,
        'enrollmentType': 'AUTO_APPROVE',
        'status': 'OPEN',
      });

      expect(course.title, '요가 클래스');
      expect(course.description, '초보 환영');
      expect(course.currentEnrollment, 3);
    });

    test('정원이 차면 isFull이 true다', () {
      expect(buildCourse(maxCapacity: 5, currentEnrollment: 5).isFull, isTrue);
      expect(buildCourse(maxCapacity: 5, currentEnrollment: 6).isFull, isTrue);
      expect(buildCourse(maxCapacity: 5, currentEnrollment: 4).isFull, isFalse);
    });

    test('remainingSpots는 잔여 정원을 반환한다', () {
      expect(buildCourse(maxCapacity: 10, currentEnrollment: 3).remainingSpots, 7);
      expect(buildCourse(maxCapacity: 5, currentEnrollment: 5).remainingSpots, 0);
    });
  });
}
