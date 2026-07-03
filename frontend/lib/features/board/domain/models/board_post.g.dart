// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardPostImpl _$$BoardPostImplFromJson(Map<String, dynamic> json) =>
    _$BoardPostImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      authorName: json['authorName'] as String,
      isPinned: json['isPinned'] as bool? ?? false,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$BoardPostImplToJson(_$BoardPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authorName': instance.authorName,
      'isPinned': instance.isPinned,
      'viewCount': instance.viewCount,
      'createdAt': instance.createdAt,
    };

_$BoardPostDetailImpl _$$BoardPostDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$BoardPostDetailImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      authorName: json['authorName'] as String,
      authorId: (json['authorId'] as num).toInt(),
      isPinned: json['isPinned'] as bool? ?? false,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$BoardPostDetailImplToJson(
        _$BoardPostDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorName': instance.authorName,
      'authorId': instance.authorId,
      'isPinned': instance.isPinned,
      'viewCount': instance.viewCount,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
    };

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      authorName: json['authorName'] as String,
      authorId: (json['authorId'] as num).toInt(),
      parentId: (json['parentId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'authorName': instance.authorName,
      'authorId': instance.authorId,
      'parentId': instance.parentId,
      'createdAt': instance.createdAt,
    };
