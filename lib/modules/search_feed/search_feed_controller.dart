

import 'package:follow_read/data/services/feed_parser_service.dart';
import 'package:get/get.dart';

class SearchFeedController extends GetxController {

  final state = SearchFeedState();
  final feedParser = Get.find<FeedParserService>();


  Future<void> search(String word) async {
    state._word.value = word;
    state.feeds.value = [];
    state._isSearching.value = true;
    final feed = await feedParser.parseFeedUrl(word);
    if (feed != null) {
      state.feeds.value = [feed];
    }
    state._isSearching.value = false;
  }

  void clear() {
    state.feeds.value = [];
    state._word.value = "";
  }

}

class SearchFeedState {
  final _word = "".obs;
  String get word => _word.value;

  final _isSearching = false.obs;
  bool get isSearching => _isSearching.value;

  final feeds = [].obs;

}