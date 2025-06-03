import 'package:get/get.dart';

import 'aisthub_controller.dart';

class AisthubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AisthubController());
  }
}
