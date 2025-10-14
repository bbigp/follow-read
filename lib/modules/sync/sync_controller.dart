import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/data/model/sync_record.dart';
import 'package:follow_read/data/services/sync_service.dart';
import 'package:follow_read/modules/count_badge/unread_controller.dart';
import 'package:follow_read/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SyncController extends GetxController {
  final state = SyncState();
  final _box = GetStorage();
  final _syncService = Get.find<SyncService>();
  final homePage = Get.find<HomeController>();
  final syncService = Get.find<SyncService>();
  final unread = Get.find<UnreadController>();

  @override
  void onInit() {
    super.onInit();
    _box.listenKey(PrefsKeys.isSyncing, (v) {
      state._isSyncing.value = v;
    });
  }

  void sync({bool checkInterval = false}) async {
    if (checkInterval) {
      var lastSyncTime = await _syncService.getLastSyncTime();
      if (lastSyncTime != null && DateTime.now().difference(lastSyncTime) < Duration(hours: 2)) {
        return;
      }
    }
    await _syncService.sync();
    await homePage.loadHomeData(loadAll: true);
    await unread.init();
  }


  Future<void> getSyncRecords({int? page}) async {
    if (page == null) {
      state._isLoading.value = true;
    } else {
      state.isLoadingMore = true;
    }
    state.page = page ?? 1;
    final records = await _syncService.syncRecords(state.page, size: state.size);
    state.records.value = page == null ? records : [...state.records, ...records];
    state.page = state.page + 1;
    state._hasMore.value = records.length >= state.size;
    state._isLoading.value = false;
    state.isLoadingMore = false;
  }

  Future<void> nextPage() async{
    await getSyncRecords(page: state.page + 1);
  }

}


class SyncState {
  final _isSyncing = false.obs;
  bool get isSyncing => _isSyncing.value;

  int page = 0;
  int size = 20;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  bool isLoadingMore = false;
  final _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  final records = <SyncRecord>[].obs;
}