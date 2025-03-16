import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/providers/auth_provider.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/bigint_mapper.dart';
import 'features/presentation/providers/app_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapperContainer.globals.use(const BigIntMapper());
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


