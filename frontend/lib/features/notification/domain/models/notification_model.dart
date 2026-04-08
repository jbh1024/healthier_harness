class AppNotification {
  final int id;
  final String type;
  final String title;
  final String message;
  final bool isRead;
  final String? referenceType;
  final int? referenceId;
  final String createdAt;

  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    this.referenceType,
    this.referenceId,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
        id: json['id'] as int,
        type: json['type'] as String,
        title: json['title'] as String,
        message: json['message'] as String,
        isRead: json['isRead'] as bool,
        referenceType: json['referenceType'] as String?,
        referenceId: json['referenceId'] as int?,
        createdAt: json['createdAt'] as String,
      );
}

class NotificationSettings {
  final bool enrollmentNotify;
  final bool noticeNotify;
  final bool commentNotify;

  const NotificationSettings({
    required this.enrollmentNotify,
    required this.noticeNotify,
    required this.commentNotify,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      NotificationSettings(
        enrollmentNotify: json['enrollmentNotify'] as bool,
        noticeNotify: json['noticeNotify'] as bool,
        commentNotify: json['commentNotify'] as bool,
      );
}
