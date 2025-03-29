import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/domain/models/sync_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../features/presentation/providers/app_container.dart';


@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      final sendPort = IsolateNameServer.lookupPortByName('main_port');
      if (sendPort == null) {
        logger.e('main_port 主端口未找到');
        return false;
      }

      final sharedPreferences = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
      );

      final completer = Completer<bool>();
      container.read(entryRepositoryProvider).syncEntries((status, progress) {
        sendPort.send({
          'status': status,
          'progress': progress,
        });
        if (status == SyncTask.status || status == SyncTask.failed) {
          completer.complete(true);
        }
      }).then((result){
        if (!completer.isCompleted) {
          completer.complete(true);
        }
      });
      return await completer.future;
    } catch (e) {
      logger.e("❌ 后台服务执行失败", error: e);
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