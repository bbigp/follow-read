



import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/modules/count_badge/unread_controller.dart';
import 'package:follow_read/modules/home/home_controller.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:follow_read/modules/sync/sync_controller.dart';
import 'package:get/get.dart';

class AddFeedController extends GetxController {
  final Feed feed;
  AddFeedController({required this.feed});
  final state = AddFeedState();
  final _feedService = Get.find<FeedService>();
  final _folderService = Get.find<FolderService>();
  final sync = Get.find<SyncController>();
  final profile = Get.find<ProfileController>();
  final homePage = Get.find<HomeController>();
  final unread = Get.find<UnreadController>();


  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    state._allFolders = await _folderService.getAllFolders();
    state._feed.value = feed;
    state._feedTitle.value = feed.title;
    state._feedUrl.value = feed.feedUrl;
    state._folder.value = state._getFolderById(feed.folderId != BigInt.zero
        ? feed.folderId
        : profile.state.user.rootFolderId
    );
  }


  void changed({String? title, String? url, BigInt? folderId}) {
    if (title != null) {
      state._feedTitle.value = title;
    }
    if (url != null) {
      state._feedUrl.value = url;
    }
    if (folderId != null){
      state._folder.value = state._getFolderById(folderId);
    }
  }

  Future<bool> save() async {
    final success = feed.id == BigInt.zero
        ? await _feedService.save(state.feedUrl, state.folder.id)
        : await _feedService.updateFeed(feed.id, title: state.feedTitle, folderId: state.folder.id);
    await homePage.loadHomeData(loadAll: true);
    await unread.init();
    if (feed.id == BigInt.zero && success) {
      sync.sync();
    }
    return success;
  }


  Future<bool> removeFeed() async {
    var result = await _feedService.removeFeed(feed.id);
    if (result) {
      await homePage.loadHomeData(loadAll: true);
      await unread.init();
    }
    return result;
  }

}

class AddFeedState {

  List<Folder> _allFolders = [];
  Folder _getFolderById(BigInt folderId) {
    return _allFolders.firstWhere((i) => i.id == folderId, orElse: () => Folder());
  }
  final _feed = Feed.empty.obs;
  Feed get feed => _feed.value;

  final _feedUrl = "".obs;
  String get feedUrl => _feedUrl.value;

  final _feedTitle = "".obs;
  String get feedTitle => _feedTitle.value;

  final _folder = Folder(title: "None").obs;
  Folder get folder => _folder.value;
}