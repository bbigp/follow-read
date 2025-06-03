



import 'package:follow_read/features/domain/models/feed.dart';
import 'package:get/get.dart';

import 'app_container.dart';

class FeedsController extends GetxController {

  final RxList<Feed> feeds = <Feed>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> init() async {
    if (isLoading.value) return;
    isLoading.value = true;
    feeds.assignAll(await feedRepository.getFeeds());
    isLoading.value = false;
  }

  Map<int, List<Feed>> get folderFeedsMap => feeds.fold<Map<int, List<Feed>>>(
        {},
        (map, feed) {
          final cid = feed.categoryId;
          map.putIfAbsent(cid, () => []);
          map[cid]!.add(feed);
          return map;
        },
      );
}