import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/modules/pages/entry_detail_page.dart';
import 'package:follow_read/modules/profile/profile_binding.dart';
import 'package:follow_read/modules/widgets/artiad/artiad_form.dart';
import 'package:follow_read/modules/widgets/me/login_1.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import 'core/utils/logger.dart';
import 'features/presentation/providers/auth_provider.dart';
import 'modules/home/home_binding.dart';
import 'modules/home/home_screen.dart';
import 'modules/login/login_controller.dart';
import 'modules/login/login_view.dart';
import 'modules/pages/entries/entries_page.dart';
import 'modules/pages/entries/meta_data.dart';
import 'deleted/home_screen.dart';
import 'modules/pages/image_gallery_page.dart';
import 'modules/pages/login_screen.dart';
import 'modules/profile/profile_page.dart';

class RouteConfig {

  static const String main = "/";

  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';
  static const login = '/login';
  static const entry = '/entry';
  static const entryDetail = '/entryDetail';
  static const imageGallery = '/imageGallery';
  static const search = '/search';
  static const filter = '/filter';
  static const addFeed = '/addFeed';

  static final List<GetPage> getPages = [
    GetPage(name: login, page: () => LoginView(), binding: LoginBinding()),

    GetPage(name: main, page: () => HomeScreen(), binding: HomeBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: profile, page: () => ProfilePage(), binding: ProfileBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: entry, page: () => EntriesPage()),
    // GetPage(name: entryDetail, page: () => EntryDetailPage()),
    // GetPage(name: imageGallery, page: () => ImageGalleryPage(imageUrls: imageUrls)),
    // GetPage(name: filter, page: page)
  ];
}

class AuthMiddleware extends GetMiddleware {

  static final List<String> publicRoutes = [
    RouteConfig.login,
  ];

  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    logger.i('[路由重定向] 登录用户: ${box.read(PrefsKeys.username)} => $route');
    final isLoggedIn = (box.read(PrefsKeys.username) ?? "").toString().isNotEmpty;
    if (!isLoggedIn && !publicRoutes.contains(route)) {
      return const RouteSettings(name: RouteConfig.login);
    }
    return null;
  }

  @override
  int? get priority => 1;

}

// final routerProvider = Provider<GoRouter>((ref) {
//   return GoRouter(
//     initialLocation: "/",
//     debugLogDiagnostics: true,
//     refreshListenable: _AuthNotifierListener(ref),
//     redirect: (context, state) {
//       final authState = ref.read(authProvider);
//       final isLoggedIn = authState.user != null;
//       final isLoggingIn = state.uri.path == '/login';
//       logger.i('[路由重定向] 登录状态: $isLoggedIn, 当前路径: ${state.uri.path}');
//
//       if (!isLoggedIn && !isLoggingIn) return '/login';
//       if (isLoggedIn && isLoggingIn) return '/';
//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: '/login',
//         name: RouteNames.login,
//         builder: (context, state) => const LoginScreen(),
//       ),
//       GoRoute(
//         path: '/',
//         name: RouteNames.home,
//         builder: (context, state) => const HomeScreen(),
//       ),
//       GoRoute(
//           path: '/profile',
//           name: RouteNames.profile,
//           builder: (context, state) => const GeneralPage()
//       ),
//       GoRoute(
//         path: '/entry/:type/:id',
//         name: RouteNames.entry,
//         builder: (context, state) {
//           final id = int.parse(state.pathParameters['id']!);
//           final type = state.pathParameters['type']!;
//           final iMata = switch(type) {
//             Model.folder => FolderMeta(id),
//             Model.artiad => ArtiadMeta(id),
//             _ => FeedMeta(id),
//           };
//           return EntriesPage(metaDatax: iMata,);
//         }
//       ),
//       GoRoute(
//           path: '/entry_detail/:entryId',
//         name: RouteNames.entryDetail,
//         builder: (context, state) {
//           final entryId = state.pathParameters['entryId']!;
//           return EntryDetailPage(entryId: int.parse(entryId));
//         }
//       ),
//       GoRoute(
//           path: '/image_gallery',
//         name: RouteNames.imageGallery,
//         builder: (context, state) {
//             final data = state.extra as Map<String, dynamic>;
//             return ImageGalleryPage(imageUrls: data['imageUrls'], initialIndex: data['index'],);
//         }
//       ),
//       // GoRoute(path: '/search/:type/:id',
//       //   name: RouteNames.search,
//       //   builder: (context, state) {
//       //     final id = int.parse(state.pathParameters['id']!);
//       //     final type = state.pathParameters['type']!;
//       //     final iMata = switch(type) {
//       //       Model.folder => Folderx(id, search: true),
//       //       Model.aist => Aistx(id, search: true),
//       //       _ => Feedx(id, search: true),
//       //     };
//       //     return SearchPage(metaDatax: iMata,);
//       //   }
//       // ),
//       // GoRoute(
//       //   path: '/cluster',
//       //   name: RouteNames.cluster,
//       //   builder: (context, state) {
//       //     final id = state.uri.queryParameters['id'] ?? "0";
//       //     return ArtiadForm(id: int.parse(id));
//       //   }
//       // ),
//     ],
//   );
// });
//
//
// class RouteNames {
//   const RouteNames._();
//   static const home = 'home';
//   static const profile = 'profile';
//   static const settings = 'settings';
//   static const login = 'login';
//   static const entry = 'entry';
//   static const entryDetail = 'entryDetail';
//   static const imageGallery = 'imageGallery';
//   static const search = 'search';
//   static const cluster = 'cluster';
//   static const addFeed = 'addFeed';
// }
//
//
// class _AuthNotifierListener extends ChangeNotifier {
//   final Ref ref;
//
//   _AuthNotifierListener(this.ref) {
//     // 当 authProvider 变化时触发路由刷新
//     ref.listen(authProvider, (_, __) {
//       logger.i(('[路由监听] 认证状态变化 → 触发刷新'));
//       notifyListeners();
//     });
//   }
// }

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