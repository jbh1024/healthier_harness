import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
class Course with _$Course {
  const Course._();

  const factory Course({
    required int id,
    required String title,
    String? description,
    required String instructorName,
    required int maxCapacity,
    required int currentEnrollment,
    required String enrollmentType,
    required String status,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseFromJson(json);

  bool get isFull => currentEnrollment >= maxCapacity;
  int get remainingSpots => maxCapacity - currentEnrollment;
}
