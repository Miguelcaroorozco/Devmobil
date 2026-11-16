import 'package:flutter_navegation/presentation/screen/about/about_screen.dart';
import 'package:flutter_navegation/presentation/screen/buttons/buttons_screen.dart';
import 'package:flutter_navegation/presentation/screen/cards/cards_screen.dart';
import 'package:flutter_navegation/presentation/screen/home/home_screen.dart';
import 'package:flutter_navegation/presentation/screen/login/login_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'Home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/buttons',
      name: 'Botones',
      builder: (context, state) => const ButtonsScreen(),
    ),
    GoRoute(
      path: '/cards',
      name: 'Tarjetas',
      builder: (context, state) => const CardsScreen(),
    ),
    GoRoute(
      path: '/about',
      name: 'Acerca de',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'Login',
      builder: (context, state) => const LoginScreen(),
    ),
  ]
);