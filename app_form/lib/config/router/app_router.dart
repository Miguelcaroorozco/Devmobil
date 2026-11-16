import 'package:app_form/presentation/screen/dashboard/dashboard_screen.dart';
import 'package:app_form/presentation/screen/login/login_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'Login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'Dashboard',
        builder: (context, state) {
          final user = state.extra as Map<String, String>? ?? const {};
          return DashboardScreen(
            name: user['name'] ?? 'Usuario',
            email: user['email'] ?? 'Sin correo',
          );
        },
      ),
    ],
  );
}
