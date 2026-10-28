import 'package:go_router/go_router.dart';
import '../pages/welcome/welcome_screen.dart';
import '../pages/portfolio/my_portfolio.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/portfolio',
      builder: (context, state) => const MyPortfolio(),
    ),
  ],
);