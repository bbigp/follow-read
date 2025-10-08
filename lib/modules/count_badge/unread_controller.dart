

import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/filter_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:get/get.dart';

class UnreadController extends GetxService {

  final _entryService = Get.find<EntryService>();
  final countMap = <String, RxInt>{};
  final _feedService = Get.find<FeedService>();
  final _folderService = Get.find<FolderService>();
  final _filterService = Get.find<FilterService>();

  final zero = 0.obs;
  int unread(String id) => countMap[id] == null ? zero.value : countMap[id]!.value;

  @override
  void onReady() {
    super.onReady();
    init();
  }

  Future<void> init() async {
    final feedMap = await _entryService.countFeed();
    for (var entry in feedMap.entries) {
      final key = 'e${entry.key}';
      final value = entry.value;

      if (countMap.containsKey(key)) {
        countMap[key]!.value = value;
      } else {
        countMap[key] = value.obs;
      }
    }

    final feeds = await _feedService.getAllFeeds();
    Map<String, int> folderUnreadMap = {};
    for (var feed in feeds) {
      final key = "o${feed.folderId}";
      folderUnreadMap[key] = (folderUnreadMap[key] ?? 0) + unread(feed.metaId);
    }
    for (var item in folderUnreadMap.entries) {
      final key = item.key;
      final value = item.value;
      if (countMap.containsKey(key)) {
        countMap[key]!.value = value;
      } else {
        countMap[key] = value.obs;
      }
    }

    final filters = await _filterService.getAllFilters();
    final filterUnreadMap = await _entryService.countFilter(filters);
    for (var item in filterUnreadMap.entries) {
      final key = 'i${item.key}';
      final value = item.value;
      if (countMap.containsKey(key)) {
        countMap[key]!.value = value;
      } else {
        countMap[key] = value.obs;
      }
    }
  }
}