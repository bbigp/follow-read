import 'package:get/get.dart';

import 'feedhub_controller.dart';

class FeedhubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedhubController());
  }
}
