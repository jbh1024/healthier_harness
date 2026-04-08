class BoardPost {
  final int id;
  final String title;
  final String authorName;
  final bool isPinned;
  final int viewCount;
  final String createdAt;

  const BoardPost({
    required this.id,
    required this.title,
    required this.authorName,
    required this.isPinned,
    required this.viewCount,
    required this.createdAt,
  });

  factory BoardPost.fromJson(Map<String, dynamic> json) => BoardPost(
        id: json['id'] as int,
        title: json['title'] as String,
        authorName: json['authorName'] as String,
        isPinned: json['isPinned'] as bool? ?? false,
        viewCount: json['viewCount'] as int? ?? 0,
        createdAt: json['createdAt'] as String,
      );
}

class BoardPostDetail {
  final int id;
  final String title;
  final String content;
  final String authorName;
  final int authorId;
  final bool isPinned;
  final int viewCount;
  final List<Comment> comments;
  final String createdAt;

  const BoardPostDetail({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.authorId,
    required this.isPinned,
    required this.viewCount,
    required this.comments,
    required this.createdAt,
  });

  factory BoardPostDetail.fromJson(Map<String, dynamic> json) =>
      BoardPostDetail(
        id: json['id'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        authorName: json['authorName'] as String,
        authorId: json['authorId'] as int,
        isPinned: json['isPinned'] as bool? ?? false,
        viewCount: json['viewCount'] as int? ?? 0,
        comments: (json['comments'] as List<dynamic>?)
                ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        createdAt: json['createdAt'] as String,
      );
}

class Comment {
  final int id;
  final String content;
  final String authorName;
  final int authorId;
  final int? parentId;
  final String createdAt;

  const Comment({
    required this.id,
    required this.content,
    required this.authorName,
    required this.authorId,
    this.parentId,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'] as int,
        content: json['content'] as String,
        authorName: json['authorName'] as String,
        authorId: json['authorId'] as int,
        parentId: json['parentId'] as int?,
        createdAt: json['createdAt'] as String,
      );
}
