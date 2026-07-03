// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AcademyImpl _$$AcademyImplFromJson(Map<String, dynamic> json) =>
    _$AcademyImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      contactInfo: json['contactInfo'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$AcademyImplToJson(_$AcademyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'contactInfo': instance.contactInfo,
      'isActive': instance.isActive,
    };
