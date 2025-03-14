import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth_provider.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.user != null;

      final isLoggingIn = state.uri.toString() == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: "login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        name: "home",
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});