


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

  void updateFolder(Category folder) {
    state = AsyncData(state.requireValue.copyWith(folder: folder));
  }

  void addUrl(String url) {
    state = AsyncData(state.requireValue.copyWith(feedUrl: url));
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
  final String feedUrl;

  const FeedFormData({
    this.folder = const Category(id: 0, title: '', ),
    this.feedUrl = '',
  });


  FeedFormData copyWith({
    Category? folder,
    String? feedUrl,
  }) {
    return FeedFormData(
      folder: folder ?? this.folder,
      feedUrl: feedUrl ?? this.feedUrl,
    );
  }

}