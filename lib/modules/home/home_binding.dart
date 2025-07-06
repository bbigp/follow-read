

import 'package:follow_read/modules/home/home_controller.dart';
import 'package:follow_read/modules/sync/sync_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(SyncController());
  }

}