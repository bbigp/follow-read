


import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/data/services/entry_service.dart';
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
  final _entryService = Get.find<EntryService>();
  final _userService = Get.find<UserService>();
  final _box = GetStorage();

  final Map<BigInt, Feed> _feedMap = {};
  final Map<BigInt, Folder> _folderMap = {};
  final Map<BigInt, Filter> _filterMap = {};

  final changeFeed = 0.obs;
  final changeFilter = 0.obs;

  final _feedLen = 0.obs;
  int get feedLen => _feedLen.value;
  final _folderLen = 0.obs;
  int get folderLen => _folderLen.value;
  final _filterLen = 0.obs;
  int get filterLen => _filterLen.value;

  final _unreadMark = UnreadMark.dot.obs;
  UnreadMark get unreadMark => _unreadMark.value;
  final countMap = <String, RxInt>{};

  final stateRootFolderId = BigInt.zero.obs;
  BigInt get rootFolderId => stateRootFolderId.value;


  bool _listening = false;
  void listen() {
    if (_listening) return;
    _listening = true;
    _box.listenKey(PrefsKeys.unreadMark, (v) {
      _unreadMark.value = UnreadMark.fromString(v);
    });
    _box.listenKey(PrefsKeys.rootFolderId, (v) {
      stateRootFolderId.value = BigInt.parse(v ?? '0');
    });
  }

  Future<void> loadUser() async {
    final user = _userService.getUser();
    stateRootFolderId.value = user.rootFolderId;
    _unreadMark.value = user.unreadMark;
    listen();
  }

  Future<void> loadFeed() async {
    final feeds = await _feedService.getAllFeeds();
    final folders = await _folderService.getAllFolders();
    _feedMap
      ..clear()
      ..addEntries(feeds.map((f) => MapEntry(f.id, f)));
    _folderMap
      ..clear()
      ..addEntries(folders.map((f) => MapEntry(f.id, f)));
    _feedLen.value = feeds.length;
    _folderLen.value = folders.length;


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
    Map<String, int> folderUnreadMap = {};
    for (var feed in feeds) {
      final key = "o${feed.folderId}";
      folderUnreadMap[key] = (folderUnreadMap[key] ?? 0) + unread('e${feed.id}');
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

    changeFeed.value++;
  }

  Future<void> loadFilter() async {
    final filters = await _filterService.getAllFilters();
    _filterMap
      ..clear()
      ..addEntries(filters.map((f) => MapEntry(f.id, f)));
    _filterLen.value = filters.length;

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

    changeFilter.value++;
  }

  Future<MemoryCacheController> load() async {
    await loadUser();
    await loadFeed();
    await loadFilter();
    return this;
  }

  Feed? getFeed(BigInt id) => _feedMap[id];
  Folder? getFolder(BigInt id) => _folderMap[id];
  Filter? getFilter(BigInt id) => _filterMap[id];
  List<Feed> get feeds => _feedMap.values.toList();
  List<Folder> get folders => _folderMap.values.toList();
  List<Filter> get filters => _filterMap.values.toList();
  int unread(String id) => countMap[id] == null ? 0 : countMap[id]!.value;

}