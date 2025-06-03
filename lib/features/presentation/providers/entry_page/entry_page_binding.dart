import 'package:get/get.dart';

import 'entry_page_controller.dart';

class EntryPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EntryPageController());
  }
}
