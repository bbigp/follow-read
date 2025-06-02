import 'dart:isolate';
import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/providers/auth_provider.dart';
import 'package:follow_read/features/presentation/providers/sync_data_provider.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:follow_read/service/background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'core/utils/bigint_mapper.dart';
import 'features/presentation/providers/app_container.dart';
import 'features/presentation/providers/controller_container.dart';

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
  setupIsolateCommunication(container);
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  await ControllerContainer.initialized();
  // debugPaintSizeEnabled = true; // 开启调试布局
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}

void setupIsolateCommunication(ProviderContainer container) {
  final receivePort = ReceivePort();

  // 注册全局端口
  IsolateNameServer.removePortNameMapping('main_port');
  IsolateNameServer.registerPortWithName(
    receivePort.sendPort,
    'main_port',
  );

  // 监听消息
  receivePort.listen((message) {
    if (message is Map<String, dynamic>) {
      final status = message["status"];
      final progress = message["progress"];
      container.read(syncProvider.notifier).updateProgress(status, progress);
    }
  });
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
      routerConfig: ref.watch(routerProvider),
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


