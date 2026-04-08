class Notice {
  final int id;
  final String title;
  final String authorName;
  final bool isImportant;
  final int viewCount;
  final String createdAt;

  const Notice({
    required this.id,
    required this.title,
    required this.authorName,
    required this.isImportant,
    required this.viewCount,
    required this.createdAt,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        id: json['id'] as int,
        title: json['title'] as String,
        authorName: json['authorName'] as String,
        isImportant: json['isImportant'] as bool? ?? false,
        viewCount: json['viewCount'] as int? ?? 0,
        createdAt: json['createdAt'] as String,
      );
}

class NoticeDetail {
  final int id;
  final String title;
  final String content;
  final String authorName;
  final bool isImportant;
  final int viewCount;
  final String createdAt;

  const NoticeDetail({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.isImportant,
    required this.viewCount,
    required this.createdAt,
  });

  factory NoticeDetail.fromJson(Map<String, dynamic> json) => NoticeDetail(
        id: json['id'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        authorName: json['authorName'] as String,
        isImportant: json['isImportant'] as bool? ?? false,
        viewCount: json['viewCount'] as int? ?? 0,
        createdAt: json['createdAt'] as String,
      );
}
