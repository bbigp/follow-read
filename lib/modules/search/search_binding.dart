
import 'package:get/get.dart';

import 'search_controller.dart';

class SearchBinding extends Bindings{
  
  @override
  void dependencies() {
    final typeId = Get.parameters['id']!;
    final type = typeId[0];
    final id = BigInt.parse(typeId.substring(1));
    Get.put(SearchHistoryController(id, type));
  }
  
}