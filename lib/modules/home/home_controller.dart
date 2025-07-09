import 'package:follow_read/core/prefs_keys.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/data/services/memory_cache_controller.dart';
import 'package:follow_read/data/services/user_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();
  final _feedService = Get.find<FeedService>();
  final _folderService = Get.find<FolderService>();
  final _userService = Get.find<UserService>();
  final _cache = Get.find<MemoryCacheController>();
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _box.listenKey(PrefsKeys.rootFolderId, (v) {
      init(rootFolderId: BigInt.parse(v ?? '0'));
    });
  }

  @override
  void onReady() {
    super.onReady();
    init(rootFolderId: _userService.getUser().rootFolderId);
  }

  void init({required BigInt rootFolderId}) async {
    // if (state.isLoading) return;
    // 设置里 选择设置root folder  config query root folder id
    // state._isLoading.value = true;

    final allFeeds = _cache.feeds;
    final allFolders = _cache.folders;

    final feedMap = allFeeds.fold<Map<BigInt, List<Feed>>>(
      {},
          (map, feed) {
        final cid = feed.folderId;
        map.putIfAbsent(cid, () => []);
        map[cid]!.add(feed);
        return map;
      },
    );


    // final rawFolders = await folderRepository.getCategories();
    // final root = rawFolders.firstWhere((c) => c.id == 1, orElse: () => Category.empty);

    // final rawFeeds = await feedRepository.getFeeds();
    state.folders = allFolders
        .where((item) => item.id != rootFolderId)
        .map((item) => item.copyWith(feeds: feedMap[item.id] ?? [],))
        .toList();
    state.stateFolderLen.value = state.folders.length;

    state.feeds = feedMap[rootFolderId] ?? [];
    state.stateFeedLen.value = state.feeds.length;
    logger.i('${state.feedLen}');

    // state.artiads = await artiadRepository.getAll();
    // state.stateArtiadLen.value = state.artiads.length;

    // state._isLoading.value = false;
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

}


class HomeState {
  HomeState();

  List<Folder> folders = [];
  List<Feed> feeds = [];
  // List<Filter> filter = [];

  final stateFolderLen = 0.obs; //控制组件重建
  final stateFeedLen = 0.obs;
  final stateArtiadLen = 0.obs;
  int get folderLen => stateFolderLen.value;
  int get feedLen => stateFeedLen.value;
  int get artiadLen => stateArtiadLen.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

}