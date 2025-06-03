import 'package:get/get.dart';

import 'folderhub_controller.dart';

class FolderhubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FolderhubController());
  }
}
