import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/enrollment/domain/models/enrollment.dart';

void main() {
  Enrollment buildEnrollment(String status, {int? waitlistPosition}) {
    return Enrollment(
      id: 1,
      courseId: 2,
      courseTitle: '필라테스',
      status: status,
      waitlistPosition: waitlistPosition,
    );
  }

  group('Enrollment', () {
    test('JSON을 파싱한다', () {
      final enrollment = Enrollment.fromJson({
        'id': 1,
        'courseId': 2,
        'courseTitle': '필라테스',
        'status': 'WAITLISTED',
        'waitlistPosition': 3,
      });

      expect(enrollment.courseTitle, '필라테스');
      expect(enrollment.waitlistPosition, 3);
    });

    test('상태별 statusLabel을 한글로 반환한다', () {
      expect(buildEnrollment('PENDING').statusLabel, '승인 대기');
      expect(buildEnrollment('APPROVED').statusLabel, '수강 중');
      expect(buildEnrollment('REJECTED').statusLabel, '거절됨');
      expect(buildEnrollment('CANCELLED').statusLabel, '취소됨');
      expect(
        buildEnrollment('WAITLISTED', waitlistPosition: 2).statusLabel,
        '대기 #2',
      );
    });

    test('알 수 없는 상태면 상태 문자열을 그대로 반환한다', () {
      expect(buildEnrollment('UNKNOWN').statusLabel, 'UNKNOWN');
    });
  });
}
