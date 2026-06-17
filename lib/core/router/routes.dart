/// Centralised route paths + names. Keeps `context.go(...)` calls free of magic
/// strings and avoids import cycles between screens.
class Routes {
  Routes._();

  static const splash = '/splash';
  static const onboarding = '/onboarding';

  static const login = '/login';
  static const register = '/register';
  static const forgot = '/forgot-password';

  // Shell tabs.
  static const home = '/home';
  static const doctors = '/doctors';
  static const appointments = '/appointments';
  static const records = '/records';
  static const account = '/account';

  // Details / flows (sub-routes under the shell where it makes sense).
  static String doctorDetail(String id) => '/doctors/$id';
  static const doctorDetailPattern = '/doctors/:id';

  static const booking = '/booking';

  static String appointmentDetail(String id) => '/appointments/$id';
  static const appointmentDetailPattern = '/appointments/:id';
  static String videoCall(String id) => '/appointments/$id/video';
  static const videoCallPattern = '/appointments/:id/video';

  static const articles = '/articles';
  static String articleDetail(String id) => '/articles/$id';
  static const articleDetailPattern = '/articles/:id';

  static const family = '/family';
  static const notifications = '/notifications';
  static const settings = '/settings';
  static const about = '/about';
}
