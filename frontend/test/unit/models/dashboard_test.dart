import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/admin/domain/models/dashboard.dart';

void main() {
  group('Dashboard', () {
    test('중첩 통계 목록을 포함해 파싱한다', () {
      final dashboard = Dashboard.fromJson({
        'totalMembers': 25,
        'totalCourses': 8,
        'activeEnrollments': 40,
        'instructorStats': [
          {
            'instructorName': '김강사',
            'courseCount': 3,
            'totalEnrollments': 20,
          },
        ],
        'studentStats': [
          {'studentName': '홍길동', 'enrolledCourses': 2},
        ],
      });

      expect(dashboard.totalMembers, 25);
      expect(dashboard.instructorStats.single.courseCount, 3);
      expect(dashboard.studentStats.single.studentName, '홍길동');
    });

    test('통계가 비어 있어도 파싱한다', () {
      final dashboard = Dashboard.fromJson({
        'totalMembers': 0,
        'totalCourses': 0,
        'activeEnrollments': 0,
        'instructorStats': <Map<String, dynamic>>[],
        'studentStats': <Map<String, dynamic>>[],
      });

      expect(dashboard.instructorStats, isEmpty);
      expect(dashboard.studentStats, isEmpty);
    });
  });
}
