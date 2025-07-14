import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/filter_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/data/services/memory_cache_controller.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();
  final _feedService = Get.find<FeedService>();
  final _folderService = Get.find<FolderService>();
  final _filterService = Get.find<FilterService>();
  final _userService = Get.find<UserService>();
  final _cache = Get.find<MemoryCacheController>();
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    everAll(
        [_cache.changeFeed, _cache.changeFolder, _cache.stateRootFolderId],
        (_) => initFeedAndFolder(_cache.rootFolderId)
    );
    ever(_cache.changeFilter, (_) => initFilter());
  }

  @override
  void onReady() {
    super.onReady();
    initFeedAndFolder(_cache.rootFolderId);
    initFilter();
  }

  void initFeedAndFolder(BigInt rootFolderId) {
    final allFolders = _cache.folders;

    final oldExpandedMap = Map<BigInt, bool>.fromEntries(
        state.folders.map((f) => MapEntry(f.id, f.expanded))
    );
    state.folders = allFolders
        .where((item) => item.id != rootFolderId && item.feeds.isNotEmpty)
        .map((item) {
          final expanded = oldExpandedMap[item.id] ?? false;
          return item.copyWith(expanded: expanded,);
        })
        .toList();
    state.stateFolderLen.value = state.folders.length;

    state.feeds = rootFolderId == BigInt.zero ? [] : allFolders.firstWhere((e) => e.id == rootFolderId).feeds;
    state.stateFeedLen.value = state.feeds.length;
    logger.i('${state.feedLen}');
  }


  void initFilter() async {
    final allFilters = _cache.filters;
    state.filters = allFilters;
    state.stateFilterLen.value = state.filters.length;
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
      await _cache.loadFilter();
    }
  }

}


class HomeState {
  HomeState();

  List<Folder> folders = [];
  List<Feed> feeds = [];
  List<Filter> filters = [];

  final stateFolderLen = 0.obs; //控制组件重建
  final stateFeedLen = 0.obs;
  final stateFilterLen = 0.obs;
  int get folderLen => stateFolderLen.value;
  int get feedLen => stateFeedLen.value;
  int get filterLen => stateFilterLen.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

}