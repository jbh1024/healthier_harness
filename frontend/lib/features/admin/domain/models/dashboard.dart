class Dashboard {
  final int totalMembers;
  final int totalCourses;
  final int activeEnrollments;
  final List<InstructorStat> instructorStats;
  final List<StudentStat> studentStats;

  const Dashboard({
    required this.totalMembers,
    required this.totalCourses,
    required this.activeEnrollments,
    required this.instructorStats,
    required this.studentStats,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        totalMembers: json['totalMembers'] as int,
        totalCourses: json['totalCourses'] as int,
        activeEnrollments: json['activeEnrollments'] as int,
        instructorStats: (json['instructorStats'] as List<dynamic>)
            .map((e) => InstructorStat.fromJson(e as Map<String, dynamic>))
            .toList(),
        studentStats: (json['studentStats'] as List<dynamic>)
            .map((e) => StudentStat.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class InstructorStat {
  final String instructorName;
  final int courseCount;
  final int totalEnrollments;

  const InstructorStat({
    required this.instructorName,
    required this.courseCount,
    required this.totalEnrollments,
  });

  factory InstructorStat.fromJson(Map<String, dynamic> json) => InstructorStat(
        instructorName: json['instructorName'] as String,
        courseCount: json['courseCount'] as int,
        totalEnrollments: json['totalEnrollments'] as int,
      );
}

class StudentStat {
  final String studentName;
  final int enrolledCourses;

  const StudentStat({
    required this.studentName,
    required this.enrolledCourses,
  });

  factory StudentStat.fromJson(Map<String, dynamic> json) => StudentStat(
        studentName: json['studentName'] as String,
        enrolledCourses: json['enrolledCourses'] as int,
      );
}
