
import 'package:follow_read/pages/home/home_controller.dart';
import 'package:get/get.dart';

class ControllerContainer {

  static Future<void> initialized() async {
    await Get.putAsync<HomeController>(() async {
      final c = HomeController();
      await c.init();
      return c;
    });
  }


}