import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_post.freezed.dart';
part 'board_post.g.dart';

@freezed
class BoardPost with _$BoardPost {
  const factory BoardPost({
    required int id,
    required String title,
    required String authorName,
    @Default(false) bool isPinned,
    @Default(0) int viewCount,
    required String createdAt,
  }) = _BoardPost;

  factory BoardPost.fromJson(Map<String, dynamic> json) =>
      _$BoardPostFromJson(json);
}

@freezed
class BoardPostDetail with _$BoardPostDetail {
  const factory BoardPostDetail({
    required int id,
    required String title,
    required String content,
    required String authorName,
    required int authorId,
    @Default(false) bool isPinned,
    @Default(0) int viewCount,
    @Default([]) List<Comment> comments,
    required String createdAt,
  }) = _BoardPostDetail;

  factory BoardPostDetail.fromJson(Map<String, dynamic> json) =>
      _$BoardPostDetailFromJson(json);
}

@freezed
class Comment with _$Comment {
  const factory Comment({
    required int id,
    required String content,
    required String authorName,
    required int authorId,
    int? parentId,
    required String createdAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
