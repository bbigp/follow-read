import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/logger.dart';
import '../../../service/background_service.dart';
import '../../data/repositories/entry_repository.dart';
import '../../domain/models/sync_task.dart';


final syncProvider = StateNotifierProvider<SyncNotifier, SyncState>(
      (ref) => SyncNotifier(
          entryRepository: ref.watch(entryRepositoryProvider),
          preferences: ref.watch(sharedPreferencesProvider))
);



class SyncNotifier extends StateNotifier<SyncState> {
  final EntryRepository entryRepository;
  final SharedPreferences preferences;

  SyncNotifier({required this.entryRepository, required this.preferences}) : super(SyncState()) {
    loadLastTask();
  }

  Future<void> loadLastTask() async {
    final status = preferences.getString(SyncTask.status);
    final exeTime = preferences.getString(SyncTask.executeTime);
    logger.i('$status');
    if (status == null || status == "" || exeTime == null || exeTime == "") {
      return;
    }
    DateTime executeTime = DateTime.parse(exeTime);
    state = state.copyWith(status: status, executeTime: executeTime);
  }

  Future<void> startSync() async {
    state = state.copyWith(status: SyncTask.syncing);
    final total = await entryRepository.syncProcess();
    if (total >= 0) {
      state = state.copyWith(total: total);
    }
    scheduleTask();
  }

  void updateProgress(String status, int progress){
    bool refreshUi = false;
    if (status == SyncTask.success){
      refreshUi = true;
    }
    state = state.copyWith(status: status, progress: progress, refreshUi: refreshUi);
  }

  void resetStatus(){
    state = state.copyWith(refreshUi: false);
  }

}



class SyncState {
  final String status;
  final int total;
  final int progress;
  final DateTime executeTime;
  final bool refreshUi;
  SyncState({this.total = 0, this.progress = 0, this.status = "", DateTime? executeTime,
  this.refreshUi = false,})
    : executeTime = executeTime ?? DateTime.now();


  SyncState copyWith({
    int? total,
    int? progress,
    String? status,
    DateTime? executeTime,
    bool? refreshUi,
  }) {
    return SyncState(
      total: total ?? this.total,
      status: status ?? this.status,
      progress: progress ?? this.progress,
        executeTime: executeTime ?? this.executeTime,
        refreshUi: refreshUi ?? this.refreshUi,
    );
  }

}










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

