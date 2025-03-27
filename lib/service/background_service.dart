import 'package:workmanager/workmanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/presentation/providers/sync_data_provider.dart';

// 全局 Provider 容器引用
ProviderContainer? _providerContainer;

void initializeWorkmanager(ProviderContainer container) {
  _providerContainer = container;

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
}

// 后台任务回调
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    final container = _providerContainer!;

    // 开始任务
    container.read(taskStatusProvider.notifier).start();

    // 模拟耗时任务
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(seconds: 1));

      // 更新进度
      container.read(taskProgressProvider.notifier).update(i);
    }

    // 标记完成
    container.read(taskStatusProvider.notifier).complete();
    return true;
  });
}

// 任务调度方法
void scheduleTask() {
  Workmanager().registerOneOffTask(
    'riverpodTask',
    'backgroundTask',
    initialDelay: Duration(seconds: 5),
    constraints: Constraints(networkType: NetworkType.connected),
  );
}