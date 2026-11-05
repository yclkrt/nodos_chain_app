import 'package:go_router/go_router.dart';
import 'package:nodos_chain_app/features/add_habit/presentation/screens/add_habit_screen.dart';
import 'package:nodos_chain_app/features/home/presentation/screens/home_screen.dart';
import 'package:nodos_chain_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:nodos_chain_app/features/stats/presentation/screens/stats_screen.dart';

/// Uygulama navigasyon rotaları.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/add-habit',
        builder: (context, state) => const AddHabitScreen(),
      ),
      GoRoute(
        path: '/stats',
        builder: (context, state) => const StatsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
