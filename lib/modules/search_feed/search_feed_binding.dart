

import 'package:follow_read/modules/search_feed/search_feed_controller.dart';
import 'package:get/get.dart';

class SearchFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchFeedController());
  }

}