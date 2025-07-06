


import 'package:follow_read/data/repositories/app_database.dart';
import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/data/services/sync_service.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:follow_read/modules/count_badge/count_badge_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class DI {

  static Future<void> register() async {
    await GetStorage.init();
    Get.put(DBService());
    Get.put(UserService());
    Get.put(EntryService());
    Get.put(SyncService());

    Get.put(CountBadgeController());//未读数
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