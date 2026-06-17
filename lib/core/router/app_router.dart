import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/account/about_screen.dart';
import '../../features/account/account_screen.dart';
import '../../features/account/settings_screen.dart';
import '../../features/appointments/appointment_detail_screen.dart';
import '../../features/appointments/appointments_screen.dart';
import '../../features/appointments/video_call_screen.dart';
import '../../features/articles/article_detail_screen.dart';
import '../../features/articles/articles_screen.dart';
import '../../features/auth/auth_controller.dart';
import '../../features/auth/forgot_password_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/booking/booking_screen.dart';
import '../../features/doctors/doctor_detail_screen.dart';
import '../../features/doctors/doctors_screen.dart';
import '../../features/family/family_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/records/records_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../shared/layout/app_shell.dart';
import 'routes.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _homeKey = GlobalKey<NavigatorState>();
final _doctorsKey = GlobalKey<NavigatorState>();
final _apptKey = GlobalKey<NavigatorState>();
final _recordsKey = GlobalKey<NavigatorState>();
final _accountKey = GlobalKey<NavigatorState>();

/// Routes that require an authenticated user. Guests hitting these are bounced
/// to login with `?from=<location>` so the flow resumes after signing in.
const _protectedPrefixes = [
  Routes.records,
  Routes.booking,
  Routes.family,
  Routes.notifications,
];

bool _isProtected(String loc) =>
    _protectedPrefixes.any((p) => loc == p || loc.startsWith('$p/'));

final routerProvider = Provider<GoRouter>((ref) {
  // Rebuild redirects whenever auth state changes.
  final refresh = ValueNotifier<int>(0);
  ref.listen(authControllerProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (loc == '/') return Routes.splash;
      final authed = ref.read(isAuthenticatedProvider);
      if (_isProtected(loc) && !authed) {
        final from = Uri.encodeComponent(state.uri.toString());
        return '${Routes.login}?from=$from';
      }
      return null;
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: Routes.onboarding, builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(path: Routes.register, builder: (_, _) => const RegisterScreen()),
      GoRoute(path: Routes.forgot, builder: (_, _) => const ForgotPasswordScreen()),

      // Full-screen detail / flow routes (over the shell).
      GoRoute(
        path: Routes.doctorDetailPattern,
        parentNavigatorKey: _rootKey,
        builder: (_, state) =>
            DoctorDetailScreen(doctorId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.booking,
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const BookingScreen(),
      ),
      GoRoute(
        path: Routes.videoCallPattern,
        parentNavigatorKey: _rootKey,
        builder: (_, state) =>
            VideoCallScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.appointmentDetailPattern,
        parentNavigatorKey: _rootKey,
        builder: (_, state) =>
            AppointmentDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.articles,
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const ArticlesScreen(),
      ),
      GoRoute(
        path: Routes.articleDetailPattern,
        parentNavigatorKey: _rootKey,
        builder: (_, state) =>
            ArticleDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.family,
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const FamilyScreen(),
      ),
      GoRoute(
        path: Routes.notifications,
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const NotificationsScreen(),
      ),
      GoRoute(
        path: Routes.settings,
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const SettingsScreen(),
      ),
      GoRoute(
        path: Routes.about,
        parentNavigatorKey: _rootKey,
        builder: (_, _) => const AboutScreen(),
      ),

      // Bottom-nav / rail shell with five branches.
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeKey,
            routes: [GoRoute(path: Routes.home, builder: (_, _) => const HomeScreen())],
          ),
          StatefulShellBranch(
            navigatorKey: _doctorsKey,
            routes: [GoRoute(path: Routes.doctors, builder: (_, _) => const DoctorsScreen())],
          ),
          StatefulShellBranch(
            navigatorKey: _apptKey,
            routes: [
              GoRoute(path: Routes.appointments, builder: (_, _) => const AppointmentsScreen()),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _recordsKey,
            routes: [GoRoute(path: Routes.records, builder: (_, _) => const RecordsScreen())],
          ),
          StatefulShellBranch(
            navigatorKey: _accountKey,
            routes: [GoRoute(path: Routes.account, builder: (_, _) => const AccountScreen())],
          ),
        ],
      ),
    ],
  );
});
