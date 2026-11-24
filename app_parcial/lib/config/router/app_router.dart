import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/feed/feed_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import '../../presentation/screens/register/register_screen.dart';

/// Notificador que reactiva GoRouter ante cualquier cambio en Firebase Auth
class GoRouterAuthNotifier extends ChangeNotifier {
  StreamSubscription<User?>? _suscripcion;

  GoRouterAuthNotifier() {
    _inicializar();
  }

  void _inicializar() {
    _suscripcion = FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _suscripcion?.cancel();
    super.dispose();
  }
}

final GoRouterAuthNotifier _notificadorAuth = GoRouterAuthNotifier();

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  refreshListenable: _notificadorAuth,
  redirect: (BuildContext contexto, GoRouterState estado) {
    final User? usuarioActual = FirebaseAuth.instance.currentUser;
    final bool sesionActiva = usuarioActual != null;
    final String ruta = estado.uri.path;

    final bool estaEnLogin = ruta == '/login';
    final bool estaEnRegistro = ruta == '/registro';

    // Sin sesión: solo puede estar en login o registro
    if (!sesionActiva) {
      if (!estaEnLogin && !estaEnRegistro) return '/login';
      return null;
    }

    // Con sesión: no puede ir a login ni registro
    if (estaEnLogin || estaEnRegistro) return '/feed';

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (contexto, estado) => const LoginScreen(),
    ),
    GoRoute(
      path: '/registro',
      name: 'registro',
      builder: (contexto, estado) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/feed',
      name: 'feed',
      builder: (contexto, estado) => const FeedScreen(),
    ),
  ],
);
