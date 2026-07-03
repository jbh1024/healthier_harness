import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthier/features/academy/domain/models/academy.dart';
import 'package:healthier/features/academy/presentation/providers/academy_provider.dart';
import 'package:healthier/features/auth/domain/models/user.dart';
import 'package:healthier/features/course/data/course_repository.dart';
import 'package:healthier/features/course/domain/models/course.dart';
import 'package:healthier/features/course/presentation/providers/course_provider.dart';

class FakeCourseRepository implements CourseRepository {
  int? requestedAcademyId;

  static const courses = [
    Course(
      id: 1,
      title: '요가 클래스',
      instructorName: '김강사',
      maxCapacity: 10,
      currentEnrollment: 3,
      enrollmentType: 'AUTO_APPROVE',
      status: 'OPEN',
    ),
  ];

  @override
  Future<List<Course>> getCourses(
    int academyId, {
    String? status,
    String? keyword,
    int page = 0,
    int size = 20,
  }) async {
    requestedAcademyId = academyId;
    return courses;
  }

  @override
  Future<Course> getCourseDetail(int academyId, int courseId) async {
    return courses.first;
  }
}

void main() {
  late FakeCourseRepository repository;
  late ProviderContainer container;

  const membership = UserAcademy(
    academyId: 7,
    academyName: '헬시어짐',
    role: 'STUDENT',
    remainingCredits: 5,
  );

  setUp(() {
    repository = FakeCourseRepository();
    container = ProviderContainer(
      overrides: [courseRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
  });

  group('courseListProvider', () {
    test('학원이 선택되지 않으면 빈 목록을 반환한다', () async {
      final courses = await container.read(courseListProvider.future);

      expect(courses, isEmpty);
      expect(repository.requestedAcademyId, isNull);
    });

    test('선택된 학원의 수업 목록을 조회한다', () async {
      container
          .read(currentAcademyProvider.notifier)
          .selectFromUserAcademy(membership);

      final courses = await container.read(courseListProvider.future);

      expect(courses, hasLength(1));
      expect(courses.first.title, '요가 클래스');
      expect(repository.requestedAcademyId, 7);
    });
  });

  group('courseDetailProvider', () {
    test('학원이 선택되지 않으면 예외를 던진다', () async {
      expect(
        () => container.read(courseDetailProvider(1).future),
        throwsException,
      );
    });

    test('선택된 학원의 수업 상세를 조회한다', () async {
      container
          .read(currentAcademyProvider.notifier)
          .selectFromUserAcademy(membership);

      final course = await container.read(courseDetailProvider(1).future);

      expect(course.title, '요가 클래스');
    });
  });

  group('학원 전환', () {
    test('학원을 전환하면 수업 목록이 새 학원 기준으로 조회된다', () async {
      final notifier = container.read(currentAcademyProvider.notifier);
      notifier.selectFromUserAcademy(membership);
      await container.read(courseListProvider.future);
      expect(repository.requestedAcademyId, 7);

      notifier.select(
        const Academy(id: 99, name: '다른학원'),
        membership,
      );

      await container.read(courseListProvider.future);
      expect(repository.requestedAcademyId, 99);
    });
  });
}
