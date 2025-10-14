

import 'package:follow_read/modules/pending_change/pending_change_controller.dart';
import 'package:get/get.dart';

class PendingChangeBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(PendingChangeController());
  }

}