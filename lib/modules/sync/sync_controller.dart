import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/data/services/sync_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SyncController extends GetxController {
  final state = SyncState();
  final _box = GetStorage();
  final _syncService = Get.find<SyncService>();

  @override
  void onInit() {
    super.onInit();
    _box.listenKey(PrefsKeys.isSyncing, (v) {
      state._isSyncing.value = v;
    });
  }

  void sync() async {
    await _syncService.sync();
  }
}


class SyncState {
  final _isSyncing = false.obs;
  bool get isSyncing => _isSyncing.value;
}