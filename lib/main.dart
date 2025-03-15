import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/providers/auth_provider.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:follow_read/features/data/datasources/database.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/presentation/providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  final sharedPreferences = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
  );
  await container.read(authProvider.notifier).initialize();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}

Future<void> initializeDatabase() async {
  AppDatabase();
  logger.i("数据库初始化完成");
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}



// return MaterialApp(
//   title: 'RSS Reader',
//   theme: ThemeData(
//     primarySwatch: Colors.blue,
//     scaffoldBackgroundColor: Colors.white,
//   ),
//   routes: AppRoutes.routes,
// onGenerateRoute: (settings) {
//   return AppRoutes.generateRoute(settings);
// },
// initialRoute: AppRoutes.feedList,
// );


