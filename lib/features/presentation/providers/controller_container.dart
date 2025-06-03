

import 'package:follow_read/features/presentation/providers/feeds_controller.dart';
import 'package:follow_read/features/presentation/providers/folders_controller.dart';
import 'package:get/get.dart';

class ControllerContainer {

  static Future<void> initialized() async {
    await Get.putAsync<FeedsController>(() async {
      final c = FeedsController();
      await c.init();
      return c;
    });
    await Get.putAsync<FoldersController>(() async {
      final c = FoldersController();
      await c.init();
      return c;
    });

  }


}