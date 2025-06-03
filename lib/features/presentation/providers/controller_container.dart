

import 'package:follow_read/features/presentation/providers/aisthub/aisthub_controller.dart';
import 'package:follow_read/features/presentation/providers/feedhub/feedhub_controller.dart';
import 'package:follow_read/features/presentation/providers/folderhub/folderhub_controller.dart';
import 'package:get/get.dart';

class ControllerContainer {

  static Future<void> initialized() async {
    await Get.putAsync<FeedhubController>(() async {
      final c = FeedhubController();
      await c.init();
      return c;
    });
    await Get.putAsync<FolderhubController>(() async {
      final c = FolderhubController();
      await c.init();
      return c;
    });
    await Get.putAsync<AisthubController>(() async {
      final c = AisthubController();
      await c.init();
      return c;
    });

  }


}