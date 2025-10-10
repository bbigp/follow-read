

import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/modules/add_feed/add_feed_controller.dart';
import 'package:get/get.dart';

class AddFeedBinding extends Bindings {

  @override
  void dependencies() {
    // final id = BigInt.parse(Get.parameters['id'] ?? "0");
    final arguments = Get.arguments;
    if (arguments != null && arguments is Feed) {
      Get.put(AddFeedController(feed: arguments));
    }
  }

}