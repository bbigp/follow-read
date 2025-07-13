

import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:get/get.dart';

class EntriesBinding extends Bindings {

  @override
  void dependencies() {
    final typeId = Get.parameters['id']!;
    final type = typeId[0];
    final id = BigInt.parse(typeId.substring(1));
    Get.put(EntriesController(id, type));
  }

}