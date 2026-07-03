import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice.freezed.dart';
part 'notice.g.dart';

@freezed
class Notice with _$Notice {
  const factory Notice({
    required int id,
    required String title,
    required String authorName,
    @Default(false) bool isImportant,
    @Default(0) int viewCount,
    required String createdAt,
  }) = _Notice;

  factory Notice.fromJson(Map<String, dynamic> json) =>
      _$NoticeFromJson(json);
}

@freezed
class NoticeDetail with _$NoticeDetail {
  const factory NoticeDetail({
    required int id,
    required String title,
    required String content,
    required String authorName,
    @Default(false) bool isImportant,
    @Default(0) int viewCount,
    required String createdAt,
  }) = _NoticeDetail;

  factory NoticeDetail.fromJson(Map<String, dynamic> json) =>
      _$NoticeDetailFromJson(json);
}
