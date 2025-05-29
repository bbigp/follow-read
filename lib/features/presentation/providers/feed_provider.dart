


import 'package:follow_read/features/data/repositories/category_repository.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/sync_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/folder.dart';
import 'folder_provider.dart';

part 'feed_provider.g.dart';

@riverpod
class AddFeedController extends _$AddFeedController {

  late final FeedRepository feedRepository = ref.watch(feedRepositoryProvider);
  late final CategoryRepository categoryRepository = ref.watch(categoryRepositoryProvider);

  @override
  FutureOr<FeedFormData> build() async {
    final folders = await ref.watch(allFoldersProvider.future);
    final all = folders.firstWhere((c) => c.title == "All", orElse: () => Category.empty);
    return FeedFormData(folder: all);
  }

  void load(int id) async {
      var feed = await feedRepository.getFeedById(id);
      var folder = await categoryRepository.getCategoryById(feed.categoryId);
      state = AsyncData(FeedFormData(feed: feed, folder: folder));
  }

  void updateFolder(Category folder) {
    state = AsyncData(state.requireValue.copyWith(folder: folder));
  }

  void addUrl(String url) {
    var feed = state.requireValue.feed;
    state = AsyncData(state.requireValue.copyWith(feed: feed.copyWith(feedUrl: url)));
  }

  void updateFeed({String? title}) {
    var feed = state.requireValue.feed;
    state = AsyncData(state.requireValue.copyWith(feed: feed.copyWith(title: title)));
  }

  Future<bool> save() async {
    var feed = state.requireValue.feed;
    var folder = state.requireValue.folder;
    if (feed.id == 0) {
      var success = await feedRepository.saveFeed(feed.feedUrl, folder.id);
      if (success) {
        ref.read(syncProvider.notifier).startSync();
        // final _ = ref.refresh(homePageProvider);
        return true;
      }
      return false;
    }
    var success = await feedRepository.updateFeed(feed.id, feed.title, folder.id);
    // final _ = ref.refresh(homePageProvider);
    // final __ = ref.refresh(entriesProvier(PageUtils.pid(TileType.feed, feed.id)));
    return success;
  }
}

class FeedFormData {
  final Category folder;
  final Feed feed;

  const FeedFormData({
    this.folder = const Category(id: 0, title: '', ),
    this.feed = const Feed(id: 0, userId: 0, feedUrl: '', siteUrl: '', title: '', ),
  });


  FeedFormData copyWith({
    Category? folder,
    Feed? feed,
  }) {
    return FeedFormData(
      folder: folder ?? this.folder,
      feed: feed ?? this.feed,
    );
  }

}