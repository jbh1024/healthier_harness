import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

@freezed
class Dashboard with _$Dashboard {
  const factory Dashboard({
    required int totalMembers,
    required int totalCourses,
    required int activeEnrollments,
    required List<InstructorStat> instructorStats,
    required List<StudentStat> studentStats,
  }) = _Dashboard;

  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);
}

@freezed
class InstructorStat with _$InstructorStat {
  const factory InstructorStat({
    required String instructorName,
    required int courseCount,
    required int totalEnrollments,
  }) = _InstructorStat;

  factory InstructorStat.fromJson(Map<String, dynamic> json) =>
      _$InstructorStatFromJson(json);
}

@freezed
class StudentStat with _$StudentStat {
  const factory StudentStat({
    required String studentName,
    required int enrolledCourses,
  }) = _StudentStat;

  factory StudentStat.fromJson(Map<String, dynamic> json) =>
      _$StudentStatFromJson(json);
}
