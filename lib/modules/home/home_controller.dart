import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/filter_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:follow_read/modules/count_badge/unread_controller.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final HomeDataState state = HomeDataState();
  final _feedService = Get.find<FeedService>();
  final _folderService = Get.find<FolderService>();
  final _filterService = Get.find<FilterService>();
  final _userService = Get.find<UserService>();
  final profile = Get.find<ProfileController>();
  final unread = Get.find<UnreadController>();
  String jsCode = "";

  @override
  void onInit() {
    super.onInit();
    // everAll(
    //     [_cache.changeFeed, _cache.changeFolder, _cache.stateRootFolderId],
    //         (_) => initFeedAndFolder(_cache.rootFolderId)
    // );
    // ever(_cache.changeFilter, (_) => initFilter());
  }

  @override
  void onReady() {
    super.onReady();
    loadHomeData(loadAll: true);
  }

  Future<void> loadHomeData({bool loadAll = false, bool loadFeeds = false, bool loadFolders = false, bool loadFilters = false}) async {
    logger.i('loadHomeData');
    //直接调用state.user.rootFolderId, 直接调用state.rootFolder可能还在加载,是空值
    final rootFolderId = profile.state.user.rootFolderId;
    final results = await Future.wait([
      _feedService.getAllFeeds(),
      // 只有当需要加载 Folders 或 Filters 时，才去加载它们对应的原始数据
      if (loadAll || loadFolders) _folderService.getAllFolders(),
      if (loadAll || loadFilters) _filterService.getAllFilters(),
    ]);
    final List<Feed> feeds = results.isNotEmpty ? results.removeAt(0) as List<Feed> : [];

    if (loadAll || loadFolders) {
      final List<Folder> folders = results.removeAt(0) as List<Folder>;
      state.folders.value = _associateFeedsWithFolders(feeds, folders, rootFolderId);
    }
    if (loadAll || loadFilters) {
      final List<Filter> filters = results.removeAt(0) as List<Filter>;
      state.filters.value = _associateFeedsWithFilters(feeds, filters);
    }
    if (loadAll || loadFeeds) {
      state.feeds.value = rootFolderId == BigInt.zero
          ? []
          : feeds.where((i) => i.folderId == rootFolderId).toList();
      logger.i('${state.feeds.length}');
    }
  }

  List<Filter> _associateFeedsWithFilters(List<Feed> feeds, List<Filter> filters) {
    final Map<BigInt, Feed> feedMap = Map.fromEntries(
      feeds.map((f) => MapEntry(f.id, f)),
    );

    return filters.map((filter) {
      final List<Feed> filterFeeds = filter.feedIds.isEmpty
          ? feeds
          : filter.feedIds
          .map((id) => feedMap[id])
          .whereType<Feed>()
          .toList();

      return filter.copyWith(feeds: filterFeeds);
    }).toList();
  }

  List<Folder> _associateFeedsWithFolders(List<Feed> feeds, List<Folder> folders, BigInt rootFolderId) {
    final folderFeedsMap = feeds.fold<Map<BigInt, List<Feed>>>(
      {},
          (map, feed) {
        final cid = feed.folderId;
        map.putIfAbsent(cid, () => []);
        map[cid]!.add(feed);
        return map;
      },
    );

    final oldExpandedMap = Map<BigInt, bool>.fromEntries(
        state.folders.map((f) => MapEntry(f.id, f.expanded))
    ); //记录旧的folder哪些是展开的，刷新的时候，保证展开状态不变
    return folders
        .where((item) => item.id != rootFolderId)
        .map((item) {
          final expanded = oldExpandedMap[item.id] ?? false;
          return item.copyWith(expanded: expanded, feeds: folderFeedsMap[item.id]);
        })
        .toList();
  }


  void expanded(BigInt id){
    final index = state.folders.indexWhere((c) => c.id == id);
    if (index == -1) {
      return;
    }
    final current = state.folders[index];
    final updated = current.copyWith(expanded: !current.expanded);
    state.folders[index] = updated;
    update(['folder_tile:$index']);
  }

  Future<void> deleteFilter(BigInt id) async {
    if (await _filterService.deleteById(id)) {
       await loadHomeData(loadFilters: true);
    }
  }

  Future<void> deleteAllRssData() async {
    await _feedService.deleteAllRssData();
    await loadHomeData(loadAll: true);
    await unread.init();
    await profile.loading();
  }

}


class HomeDataState {
  HomeDataState();

  RxList<Folder> folders = <Folder>[].obs;
  RxList<Feed> feeds = <Feed>[].obs;
  RxList<Filter> filters = <Filter>[].obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

}