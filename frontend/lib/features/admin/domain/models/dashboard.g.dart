// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardImpl _$$DashboardImplFromJson(Map<String, dynamic> json) =>
    _$DashboardImpl(
      totalMembers: (json['totalMembers'] as num).toInt(),
      totalCourses: (json['totalCourses'] as num).toInt(),
      activeEnrollments: (json['activeEnrollments'] as num).toInt(),
      instructorStats: (json['instructorStats'] as List<dynamic>)
          .map((e) => InstructorStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      studentStats: (json['studentStats'] as List<dynamic>)
          .map((e) => StudentStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DashboardImplToJson(_$DashboardImpl instance) =>
    <String, dynamic>{
      'totalMembers': instance.totalMembers,
      'totalCourses': instance.totalCourses,
      'activeEnrollments': instance.activeEnrollments,
      'instructorStats':
          instance.instructorStats.map((e) => e.toJson()).toList(),
      'studentStats': instance.studentStats.map((e) => e.toJson()).toList(),
    };

_$InstructorStatImpl _$$InstructorStatImplFromJson(Map<String, dynamic> json) =>
    _$InstructorStatImpl(
      instructorName: json['instructorName'] as String,
      courseCount: (json['courseCount'] as num).toInt(),
      totalEnrollments: (json['totalEnrollments'] as num).toInt(),
    );

Map<String, dynamic> _$$InstructorStatImplToJson(
        _$InstructorStatImpl instance) =>
    <String, dynamic>{
      'instructorName': instance.instructorName,
      'courseCount': instance.courseCount,
      'totalEnrollments': instance.totalEnrollments,
    };

_$StudentStatImpl _$$StudentStatImplFromJson(Map<String, dynamic> json) =>
    _$StudentStatImpl(
      studentName: json['studentName'] as String,
      enrolledCourses: (json['enrolledCourses'] as num).toInt(),
    );

Map<String, dynamic> _$$StudentStatImplToJson(_$StudentStatImpl instance) =>
    <String, dynamic>{
      'studentName': instance.studentName,
      'enrolledCourses': instance.enrolledCourses,
    };
