import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/presentation/providers/auth_provider.dart';
import '../features/presentation/screens/home_screen.dart';
import '../features/presentation/screens/login_screen.dart';


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


// import 'package:flutter/material.dart';
// import 'package:follow_read/features/presentation/screens/entries_page.dart';
// import 'package:follow_read/features/presentation/screens/example.dart';
// import 'package:follow_read/features/presentation/screens/home.dart';
//
// import '../features/data/models/feed.dart';
// import '../features/presentation/screens/me_page.dart';
//
//
// class AppRoutes {
//   static const String feedList = '/feeds';
//   static const String entryList = "/entries";
//   static const String me = "/me";
//   static const String example = "/example";
//
//   static Map<String, WidgetBuilder> routes = {
//     feedList: (context) => const MyHomePage(),
//   };
//
//   static Route<dynamic>? generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRoutes.feedList:
//         return MaterialPageRoute(
//           builder: (context) => MyHomePage(),
//         );
//         // final item = settings.arguments as Feed;
//         // return MaterialPageRoute(
//         //   builder: (context) => MyHomePage(item: item),
//         // );
//       case AppRoutes.entryList:
//         final feed = settings.arguments as Feed;
//         return MaterialPageRoute(builder: (context) => EntryListPage(feed: feed));
//       case AppRoutes.me:
//         return MaterialPageRoute(builder: (context) => MePage());
//         case AppRoutes.example:
//           return MaterialPageRoute(builder: (context) => ShimmerListExample());
//       default:
//         return MaterialPageRoute(
//           builder: (context) => const MyHomePage(),
//         );
//     }
//   }
//
//   static Future<T?> navigateTo<T>(BuildContext context, String routeName, {Object? arguments}) {
//     return Navigator.pushNamed<T>(
//       context,
//       routeName,
//       arguments: arguments,
//     );
//   }
//
//
// }