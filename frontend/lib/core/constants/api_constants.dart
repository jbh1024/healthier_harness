class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://localhost:8080/api';

  // Auth
  static const String signup = '/auth/signup';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refresh = '/auth/refresh';
  static const String joinAcademy = '/auth/join-academy';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User
  static const String me = '/users/me';

  // Academy
  static const String academies = '/academies';
  static String academyDetail(int id) => '/academies/$id';
  static String academyMembers(int id) => '/academies/$id/members';

  // Course
  static String courses(int academyId) => '/academies/$academyId/courses';
  static String courseDetail(int academyId, int courseId) =>
      '/academies/$academyId/courses/$courseId';

  // Enrollment
  static String enrollments(int academyId, int courseId) =>
      '/academies/$academyId/courses/$courseId/enrollments';

  // Board
  static String board(int academyId) => '/academies/$academyId/board';
  static String boardDetail(int academyId, int postId) =>
      '/academies/$academyId/board/$postId';

  // Notice
  static String notices(int academyId) => '/academies/$academyId/notices';
  static String noticeDetail(int academyId, int noticeId) =>
      '/academies/$academyId/notices/$noticeId';
}
