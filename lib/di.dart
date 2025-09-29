


import 'package:follow_read/data/repositories/app_database.dart';
import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/filter_service.dart';
import 'package:follow_read/data/services/memory_cache_controller.dart';
import 'package:follow_read/data/services/sync_service.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:follow_read/modules/count_badge/unread_controller.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'data/services/folder_service.dart';


class DI {

  static Future<void> register() async {
    await GetStorage.init();
    Get.put(DBService());
    Get.put(UserService());
    Get.put(EntryService());
    Get.put(SyncService());
    Get.put(FeedService());
    Get.put(FolderService());
    Get.put(FilterService());
    Get.put(ProfileController());
    Get.put(UnreadController());

    await Get.putAsync(() => MemoryCacheController().load());
  }
}

class DBService extends GetxService {
  late final AppDatabase db;

  @override
  void onInit() {
    super.onInit();
    db = AppDatabase();
  }

  @override
  void onClose() {
    db.close();
    super.onClose();
  }
}