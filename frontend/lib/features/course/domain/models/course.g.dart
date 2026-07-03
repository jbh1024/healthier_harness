// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      instructorName: json['instructorName'] as String,
      maxCapacity: (json['maxCapacity'] as num).toInt(),
      currentEnrollment: (json['currentEnrollment'] as num).toInt(),
      enrollmentType: json['enrollmentType'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'instructorName': instance.instructorName,
      'maxCapacity': instance.maxCapacity,
      'currentEnrollment': instance.currentEnrollment,
      'enrollmentType': instance.enrollmentType,
      'status': instance.status,
    };
