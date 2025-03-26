
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/feed_repository.dart';
import '../../domain/models/feed.dart';
import 'app_container.dart';

final feedDetailProvider = StateNotifierProvider.autoDispose.family<
    FeedDetailNotifier, AsyncValue<Feed>, int>((ref, feedId) {
  return FeedDetailNotifier(
      feedId: feedId,
      repository: ref.watch(feedRepositoryProvider),
  );
});

class FeedDetailNotifier extends StateNotifier<AsyncValue<Feed>> {

  final FeedRepository repository;
  final int feedId;
  FeedDetailNotifier({required this.repository, required this.feedId,})
      : super(const AsyncValue.loading()) {
    // fetchFeed();
  }

  Future<void> fetchFeed() async {
    state = const AsyncValue.loading();
    final feed = await repository.getFeedById(feedId);
    state = AsyncValue.data(feed);
  }

  Future<void> saveShow({bool? onlyShowUnread, bool? showReadingTime}) async{
    final success = await repository.updateShow(feedId,
        onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime,
    );
    if (success) {
      state.whenData((data){
        final feed = data.copyWith(onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime);
        state = AsyncData(feed);
      });
    }
  }
}