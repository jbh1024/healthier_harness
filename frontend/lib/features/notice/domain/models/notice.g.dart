// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoticeImpl _$$NoticeImplFromJson(Map<String, dynamic> json) => _$NoticeImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      authorName: json['authorName'] as String,
      isImportant: json['isImportant'] as bool? ?? false,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$NoticeImplToJson(_$NoticeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authorName': instance.authorName,
      'isImportant': instance.isImportant,
      'viewCount': instance.viewCount,
      'createdAt': instance.createdAt,
    };

_$NoticeDetailImpl _$$NoticeDetailImplFromJson(Map<String, dynamic> json) =>
    _$NoticeDetailImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      authorName: json['authorName'] as String,
      isImportant: json['isImportant'] as bool? ?? false,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$NoticeDetailImplToJson(_$NoticeDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorName': instance.authorName,
      'isImportant': instance.isImportant,
      'viewCount': instance.viewCount,
      'createdAt': instance.createdAt,
    };
