import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/pages/feed_creator.dart';
import 'package:follow_read/features/presentation/pages/entry_detail_page.dart';
import 'package:follow_read/features/presentation/pages/entry_page.dart';
import 'package:follow_read/features/presentation/pages/image_gallery_page.dart';
import 'package:follow_read/features/presentation/pages/search_page.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/logger.dart';
import '../features/domain/models/tile.dart';
import '../features/presentation/pages/cluster_page.dart';
import '../features/presentation/pages/general_page.dart';
import '../features/presentation/pages/home_screen.dart';
import '../features/presentation/pages/login_screen.dart';
import '../features/presentation/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    refreshListenable: _AuthNotifierListener(ref),
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.user != null;
      final isLoggingIn = state.uri.path == '/login';
      logger.i('[路由重定向] 登录状态: $isLoggedIn, 当前路径: ${state.uri.path}');

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: '/profile',
          name: RouteNames.profile,
          builder: (context, state) => const GeneralPage()
      ),
      GoRoute(
        path: '/entry/:type/:id',
        name: RouteNames.entry,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final type = state.pathParameters['type']!;
          return EntryPage(
            id: int.parse(id),
            type: TileType.fromString(type),
          );
        }
      ),
      GoRoute(
          path: '/entry_detail/:entryId',
        name: RouteNames.entryDetail,
        builder: (context, state) {
          final entryId = state.pathParameters['entryId']!;
          return EntryDetailPage(entryId: int.parse(entryId));
        }
      ),
      GoRoute(
          path: '/image_gallery',
        name: RouteNames.imageGallery,
        builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return ImageGalleryPage(imageUrls: data['imageUrls'], initialIndex: data['index'],);
        }
      ),
      GoRoute(path: '/search/:type/:id',
      name: RouteNames.search,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final type = state.pathParameters['type']!;
          return SearchPage(
            id: int.parse(id),
            type: TileType.fromString(type),
          );
        }
      ),
      GoRoute(
        path: '/cluster',
        name: RouteNames.cluster,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'] ?? "0";
          return ClusterPage(id: int.parse(id));
        }
      ),
      GoRoute(
        path: '/add/feed',
        name: RouteNames.addFeed,
        builder: (context, state) {
          return FeedCreator();
        }
      )
    ],
  );
});


class RouteNames {
  const RouteNames._();
  static const home = 'home';
  static const profile = 'profile';
  static const settings = 'settings';
  static const login = 'login';
  static const entry = 'entry';
  static const entryDetail = 'entryDetail';
  static const imageGallery = 'imageGallery';
  static const search = 'search';
  static const cluster = 'cluster';
  static const addFeed = 'addFeed';
}


class _AuthNotifierListener extends ChangeNotifier {
  final Ref ref;

  _AuthNotifierListener(this.ref) {
    // 当 authProvider 变化时触发路由刷新
    ref.listen(authProvider, (_, __) {
      logger.i(('[路由监听] 认证状态变化 → 触发刷新'));
      notifyListeners();
    });
  }
}

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