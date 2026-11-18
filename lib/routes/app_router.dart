import 'package:go_router/go_router.dart';
import '../pages/welcome/welcome_screen.dart';
import '../pages/portfolio/my_portfolio.dart';
import '../pages/trails/trails_screen.dart';
import '../pages/settings/settings_screen.dart';
import '../pages/auth/login_screen.dart';
import '../pages/auth/register_screen.dart';
import '../pages/auth/check_auth_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/check', // El punto de entrada ahora es la validación
  routes: [
    GoRoute(
      path: '/check',
      builder: (context, state) => const CheckAuthScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/portfolio',
      builder: (context, state) => const MyPortfolio(),
    ),
    GoRoute(
      path: '/trails',
      builder: (context, state) => const TrailsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);