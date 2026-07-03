// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      academies: (json['academies'] as List<dynamic>?)
              ?.map((e) => UserAcademy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'profileImageUrl': instance.profileImageUrl,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'academies': instance.academies.map((e) => e.toJson()).toList(),
    };

_$UserAcademyImpl _$$UserAcademyImplFromJson(Map<String, dynamic> json) =>
    _$UserAcademyImpl(
      academyId: (json['academyId'] as num).toInt(),
      academyName: json['academyName'] as String,
      role: json['role'] as String,
      remainingCredits: (json['remainingCredits'] as num).toInt(),
    );

Map<String, dynamic> _$$UserAcademyImplToJson(_$UserAcademyImpl instance) =>
    <String, dynamic>{
      'academyId': instance.academyId,
      'academyName': instance.academyName,
      'role': instance.role,
      'remainingCredits': instance.remainingCredits,
    };
