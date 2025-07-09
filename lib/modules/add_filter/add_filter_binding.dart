

import 'package:follow_read/modules/add_filter/add_filter_controller.dart';
import 'package:get/get.dart';

class AddFilterBinding extends Bindings {

  @override
  void dependencies() {
    final id = BigInt.parse(Get.parameters['id'] ?? "0");
    Get.put(AddFilterController(id));
  }

}