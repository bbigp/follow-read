import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../features/presentation/providers/app_container.dart';



// 后台任务回调
// @pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {

    final sharedPreferences = await SharedPreferences.getInstance();
    final backgroundContainer = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
    );

    // 执行任务逻辑
    try {
      for (int i = 0; i <= 10; i++) {
        await Future.delayed(Duration(seconds: 1));
        logger.i('dsds');
      }
      return true;
    } catch (e) {
      print('任务失败: $e');
      return false;
    }
  });
}

// 任务调度方法
void scheduleTask() {
  Workmanager().registerOneOffTask(
    'riverpodTask',
    'backgroundTask',
    initialDelay: Duration(seconds: 1),
    constraints: Constraints(networkType: NetworkType.connected),
      // inputData: {'key': 'value'},
  );
}