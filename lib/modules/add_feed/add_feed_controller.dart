



import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/memory_cache_controller.dart';
import 'package:follow_read/modules/sync/sync_controller.dart';
import 'package:get/get.dart';

class AddFeedController extends GetxController {
  final BigInt id;
  AddFeedController({required this.id});
  final state = AddFeedState();
  final _cache = Get.find<MemoryCacheController>();
  final _feedService = Get.find<FeedService>();
  final _syncService = Get.find<SyncController>();


  @override
  void onReady() {
    super.onReady();
    if (id != BigInt.zero) {
      final feed = _cache.getFeed(id) ?? Feed();
      state._feedTitle.value = feed.title;
      state._feedUrl.value = feed.feedUrl;
      state._folder.value = _cache.getFolder(feed.folderId) ?? Folder();
    } else {
      state._folder.value = _cache.getFolder(_cache.rootFolderId) ?? Folder();
    }
  }


  void changed({String? title, String? url, BigInt? folderId}) {
    if (title != null) {
      state._feedTitle.value = title;
    }
    if (url != null) {
      state._feedUrl.value = url;
    }
    if (folderId != null){
      state._folder.value = _cache.getFolder(folderId) ?? Folder();
    }
  }

  Future<bool> save() async {
    final success = id == BigInt.zero
        ? await _feedService.save(state.feedUrl, state.folder.id)
        : await _feedService.updateFeed(id, title: state.feedTitle, folderId: state.folder.id);
    await _cache.loadFeed();
    if (id == BigInt.zero && success) {
      _syncService.sync();
    }
    return success;
  }

}

class AddFeedState {

  // Feed feed = Feed.empty;

  final _feedUrl = "".obs;
  String get feedUrl => _feedUrl.value;

  final _feedTitle = "".obs;
  String get feedTitle => _feedTitle.value;

  final _folder = Folder(title: "None").obs;
  Folder get folder => _folder.value;
}