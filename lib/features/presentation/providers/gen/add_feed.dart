


import 'package:follow_read/features/data/repositories/category_repository.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/feeds_controller.dart';
import 'package:follow_read/features/presentation/providers/feeds_provider.dart';
import 'package:follow_read/features/presentation/providers/folders_controller.dart';
import 'package:follow_read/features/presentation/providers/sync_data_provider.dart';
import 'package:get/get.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AddFeedController extends GetxController {
  final int feedId;
  AddFeedController(this.feedId);

  late final FeedsController _feedsController;
  late final FoldersController _foldersController;
  final feedUrl = "".obs;
  final feedTitle = "".obs;

  final Rx<Feed> _feed = Feed.empty.obs;
  Feed get feed => _feed.value;
  set feed(Feed f) => _feed.value = f;

  final Rx<Category> _folder = Category.empty.obs;
  Category get folder => _folder.value;
  set folder(Category f) => _folder.value = f;

  @override
  void onInit() {
    super.onInit();
    _foldersController = Get.find<FoldersController>();
    _feedsController = Get.find<FeedsController>();
    if (feedId == 0) {
      folder = _foldersController.folders.firstWhere((c) => c.title == "All", orElse: () => Category.empty);
    } else {
      feed = _feedsController.feeds.firstWhere((c) => c.id == feedId, orElse: () => Feed.empty);
      if (feed.id <= 0) {
        folder = Category.empty;
        return;
      }
      feedUrl.value = feed.feedUrl;
      feedTitle.value = feed.title;
      folder = _foldersController.folders.firstWhere((c) => c.id == feed.categoryId, orElse: () => Category.empty);
    }
  }

  void changed({String? title, String? url, Category? chooseFolder}) {
    if (title != null) {
      feedTitle.value = title;
    }
    if (url != null) {
      feedUrl.value = url;
    }
    if (chooseFolder != null){
      folder = chooseFolder;
    }
  }

  bool get isEditing => feed.id > 0;

  Future<bool> save() async {
    if (!isEditing) {
      var success = await feedRepository.saveFeed(feedUrl.value, folder.id);
      if (success) {
        // ref.read(syncProvider.notifier).startSync();
        return true;
      }
      return false;
    }
    var success = await feedRepository.updateFeed(feed.id, feedTitle.value, folder.id);
    await _feedsController.init();
    return success;
  }


}

//创建一个 AddFeedBinding，用于集中管理控制器注入：
//
//// add_feed_binding.dart
//import 'package:get/get.dart';
//import 'add_feed.dart';
//
//class AddFeedBinding extends Bindings {
//  final int feedId;
//  AddFeedBinding(this.feedId);
//
//  @override
//  void dependencies() {
//    Get.lazyPut<AddFeedController>(() => AddFeedController(feedId));
//  }
//}
//调用页面时使用：
//Get.to(() => FeedCreator(id: 1), binding: AddFeedBinding(1));


final addFeedProvider = AutoDisposeAsyncNotifierProvider<AddFeedNotifier, AddFeedController111>(
  AddFeedNotifier.new,
);

class AddFeedNotifier extends AutoDisposeAsyncNotifier<AddFeedController111> {

  late final FeedRepository feedRepository = ref.watch(feedRepositoryProvider);
  late final CategoryRepository categoryRepository = ref.watch(categoryRepositoryProvider);

  @override
  FutureOr<AddFeedController111> build() async {
    print("addfeed build");
    ref.onDispose((){
      print("addfeed onDispose");
    });

    // final folders = await ref.watch(foldersProvider.future);
    // final all = folders.firstWhere((c) => c.title == "All", orElse: () => Category.empty);
    return AddFeedController111();
  }

  void load(int id) async {
    print("addfeed load");
      var feed = await feedRepository.getFeedById(id);
      var folder = await categoryRepository.getCategoryById(feed.categoryId);
      state = AsyncData(AddFeedController111(feed: feed, folder: folder));
  }

  void updateFolder(Category folder) {
    state = AsyncData(state.requireValue.copyWith(folder: folder));
  }

  Future<bool> save({String title = "", String url = ""}) async {
    print("addfeed save");
    var feed = state.requireValue.feed;
    var folder = state.requireValue.folder;
    if (feed.id == 0) {
      var success = await feedRepository.saveFeed(url, folder.id);
      if (success) {
        ref.read(syncProvider.notifier).startSync();
        return true;
      }
      return false;
    }
    var success = await feedRepository.updateFeed(feed.id, title, folder.id);
    final _ = ref.refresh(feedsProvider);
    return success;
  }
}

class AddFeedController111 {
  final Category folder;
  final Feed feed;

  const AddFeedController111({
    this.folder = const Category(id: 0, title: '', ),
    this.feed = const Feed(id: 0, userId: 0, feedUrl: '', siteUrl: '', title: '', ),
  });


  AddFeedController111 copyWith({
    Category? folder,
    Feed? feed,
  }) {
    return AddFeedController111(
      folder: folder ?? this.folder,
      feed: feed ?? this.feed,
    );
  }

}