import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/academy/presentation/providers/academy_provider.dart';
import '../features/academy/presentation/screens/academy_join_screen.dart';
import '../features/academy/presentation/screens/academy_select_screen.dart';
import '../features/academy/presentation/screens/home_screen.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/course/presentation/screens/course_detail_screen.dart';
import '../features/course/presentation/screens/course_list_screen.dart';
import '../features/enrollment/presentation/screens/my_enrollments_screen.dart';
import '../features/board/presentation/screens/board_list_screen.dart';
import '../features/board/presentation/screens/board_detail_screen.dart';
import '../features/board/presentation/screens/board_write_screen.dart';
import '../features/notice/presentation/screens/notice_list_screen.dart';
import '../features/notice/presentation/screens/notice_detail_screen.dart';
import '../features/notification/presentation/screens/notification_list_screen.dart';
import '../features/notification/presentation/screens/notification_settings_screen.dart';
import '../features/admin/presentation/screens/dashboard_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/password_change_screen.dart';
import '../features/auth/presentation/screens/security_settings_screen.dart';
import 'route_names.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final academyState = ref.watch(currentAcademyProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';
      final isAcademySelected = academyState.isSelected;

      // 미인증 → 로그인으로
      if (!isAuthenticated && !isAuthRoute) {
        return '/login';
      }

      // 인증 완료 + 인증 화면 접근 → 학원 선택 또는 홈으로
      if (isAuthenticated && isAuthRoute) {
        return isAcademySelected ? '/home' : '/academy-select';
      }

      // 인증 완료 + 학원 미선택 + 학원 관련 아닌 경로
      if (isAuthenticated &&
          !isAcademySelected &&
          state.matchedLocation != '/academy-select' &&
          state.matchedLocation != '/academy-join') {
        return '/academy-select';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/academy-select',
        name: RouteNames.academySelect,
        builder: (context, state) => const AcademySelectScreen(),
      ),
      GoRoute(
        path: '/academy-join',
        name: RouteNames.academyJoin,
        builder: (context, state) => const AcademyJoinScreen(),
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const CourseListScreen(),
      ),
      GoRoute(
        path: '/courses/:courseId',
        builder: (context, state) {
          final courseId = int.parse(state.pathParameters['courseId']!);
          return CourseDetailScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/enrollments/me',
        builder: (context, state) => const MyEnrollmentsScreen(),
      ),
      GoRoute(
        path: '/board',
        builder: (context, state) => const BoardListScreen(),
      ),
      GoRoute(
        path: '/board/write',
        builder: (context, state) => const BoardWriteScreen(),
      ),
      GoRoute(
        path: '/board/:postId',
        builder: (context, state) {
          final postId = int.parse(state.pathParameters['postId']!);
          return BoardDetailScreen(postId: postId);
        },
      ),
      GoRoute(
        path: '/notices',
        builder: (context, state) => const NoticeListScreen(),
      ),
      GoRoute(
        path: '/notices/:noticeId',
        builder: (context, state) {
          final noticeId = int.parse(state.pathParameters['noticeId']!);
          return NoticeDetailScreen(noticeId: noticeId);
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationListScreen(),
      ),
      GoRoute(
        path: '/settings/notifications',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings/password',
        builder: (context, state) => const PasswordChangeScreen(),
      ),
      GoRoute(
        path: '/settings/security',
        builder: (context, state) => const SecuritySettingsScreen(),
      ),
    ],
  );
});
