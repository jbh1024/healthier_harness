class AppConstants {
  AppConstants._();

  static const int defaultPageSize = 20;
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const int maxProfileImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxAttachmentCount = 5;

  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedAttachmentExtensions = [
    'jpg', 'jpeg', 'png', 'gif', 'pdf', 'doc', 'docx', 'hwp', 'xls', 'xlsx'
  ];
}
