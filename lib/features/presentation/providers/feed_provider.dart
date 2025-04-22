


import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/sync_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/category.dart';
import 'folder_provider.dart';

part 'feed_provider.g.dart';

@riverpod
class AddFeedController extends _$AddFeedController {

  @override
  FutureOr<FeedFormData> build() async {
    final folders = await ref.watch(allFoldersProvider.future);
    final all = folders.firstWhere((c) => c.title == "All", orElse: () => Category.empty);
    return FeedFormData(folder: all);
  }

  void load(int id) async {
      var feed = await ref.watch(feedRepositoryProvider).getFeedById(id);
      var folder = await ref.watch(categoryRepository).getCategoryById(feed.categoryId);
      state = AsyncData(FeedFormData(feed: feed, folder: folder));
  }

  void updateFolder(Category folder) {
    state = AsyncData(state.requireValue.copyWith(folder: folder));
  }

  void addUrl(String url) {
    state = AsyncData(state.requireValue.copyWith(feed: state.requireValue.feed.copyWith(feedUrl: url)));
  }

  void updateFeed({String? title}) {
    state = AsyncData(state.requireValue.copyWith(feed: state.requireValue.feed.copyWith(title: title)));
  }

  Future<bool> save() async {
    if (await ref.read(feedRepositoryProvider).saveFeed(state.requireValue)) {
      ref.read(syncProvider.notifier).startSync();
      return true;
    }
    return false;
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