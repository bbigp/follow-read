


import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/filter_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MemoryCacheController extends GetxService {

  final _feedService = Get.find<FeedService>();
  final _folderService = Get.find<FolderService>();
  final _filterService = Get.find<FilterService>();
  final _userService = Get.find<UserService>();
  final _box = GetStorage();

  final Map<BigInt, Feed> _feedMap = {};
  final Map<BigInt, Folder> _folderMap = {};
  final Map<BigInt, Filter> _filterMap = {};

  final _feedLen = 0.obs;
  int get feedLen => _feedLen.value;
  final _folderLen = 0.obs;
  int get folderLen => _folderLen.value;
  final _unreadMark = UnreadMark.dot.obs;
  UnreadMark get unreadMark => _unreadMark.value;

  final countMap = <String, int>{}.obs;

  void listen() {
    _box.listenKey(PrefsKeys.unreadMark, (v) {
      _unreadMark.value = UnreadMark.fromString(v);
    });
  }

  Future<MemoryCacheController> load() async {
    final user = _userService.getUser();
    final feeds = await _feedService.getAllFeeds();
    final folders = await _folderService.getAllFolders();
    final filters = await _filterService.getAllFilters();

    _unreadMark.value = user.unreadMark;
    _feedLen.value = feeds.length;
    _folderLen.value = folders.length;

    _feedMap
      ..clear()
      ..addEntries(feeds.map((f) => MapEntry(f.id, f)));

    _folderMap
      ..clear()
      ..addEntries(folders.map((f) => MapEntry(f.id, f)));

    _filterMap
      ..clear()
      ..addEntries(filters.map((f) => MapEntry(f.id, f)));

    listen();
    return this;
  }

  Feed? getFeed(BigInt id) => _feedMap[id];
  Folder? getFolder(BigInt id) => _folderMap[id];
  Filter? getFilter(BigInt id) => _filterMap[id];
  List<Feed> get feeds => _feedMap.values.toList();
  List<Folder> get folders => _folderMap.values.toList();
  List<Filter> get filters => _filterMap.values.toList();
  int unread(String id) => countMap[id] ?? 1;

}