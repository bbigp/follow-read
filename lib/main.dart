import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:follow_read/features/data/datasources/database.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/data/models/user_model.dart';
import 'features/domain/use_cases/app_router.dart';
import 'features/domain/use_cases/login_use_case.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  final sharedPreferences = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
  );
  final user = await container.read(getCurrentUserUseCaseProvider).execute();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(user: user),
    ),
  );
}

Future<void> initializeDatabase() async {
  AppDatabase();
  logger.i("数据库初始化完成");
}

class MyApp extends ConsumerWidget {
  final UserModel? user;
  const MyApp({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: router,
    );
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
  }
}



