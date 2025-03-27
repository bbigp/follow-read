import 'package:flutter_riverpod/flutter_riverpod.dart';

// 任务状态定义
enum TaskStatus { idle, running, paused, completed }

// 状态通知器
class TaskNotifier extends StateNotifier<TaskStatus> {
  TaskNotifier() : super(TaskStatus.idle);
  void start() => state = TaskStatus.running;
  void pause() => state = TaskStatus.paused;
  void complete() => state = TaskStatus.completed;
  void reset() => state = TaskStatus.idle;
}

// 进度通知器
class ProgressNotifier extends StateNotifier<int> {
  ProgressNotifier() : super(0);

  void update(int newProgress) => state = newProgress;
  void reset() => state = 0;
}

// Provider 定义
final taskStatusProvider = StateNotifierProvider<TaskNotifier, TaskStatus>(
      (ref) => TaskNotifier(),
);

final taskProgressProvider = StateNotifierProvider<ProgressNotifier, int>(
      (ref) => ProgressNotifier(),
);