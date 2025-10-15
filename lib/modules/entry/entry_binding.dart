

import 'package:get/get.dart';

import 'entry_controller.dart';

class EntryBinding extends Bindings {

  @override
  void dependencies() {
    final id = Get.parameters['id'] ?? "0";
    Get.put(EntryController(BigInt.parse(id)));
  }

}