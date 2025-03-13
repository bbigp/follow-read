import 'package:flutter/material.dart';
import 'package:follow_read/routes.dart';
import 'package:follow_read/services/database.dart';
import 'package:follow_read/utils/logger.dart';
import 'package:logger/logger.dart';

void main() async {
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // 不显示方法调用栈
      colors: true,
      printEmojis: false,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

Future<void> initializeDatabase() async {
  AppDatabase();
  logger.i("数据库初始化完成");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSS Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // routes: AppRoutes.routes,
      onGenerateRoute: (settings) {
        return AppRoutes.generateRoute(settings);
      },
      initialRoute: AppRoutes.feedList,
    );
  }
}



