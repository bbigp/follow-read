
import 'package:follow_read/modules/controller/feeds/feeds_controller.dart';
import 'package:follow_read/modules/controller/folders/folders_controller.dart';
import 'package:follow_read/modules/controller/home/home_controller.dart';
import 'package:get/get.dart';

class ControllerContainer {

  static Future<void> initialized() async {
    await Get.putAsync<HomeController>(() async {
      final c = HomeController();
      await c.init();
      return c;
    });
    Get.lazyPut(() => FoldersController());
    Get.lazyPut(() => FeedsController());
  }


}