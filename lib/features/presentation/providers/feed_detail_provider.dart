
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/logger.dart';
import '../../data/repositories/feed_repository.dart';
import '../../domain/models/feed.dart';
import 'app_container.dart';

final feedDetailProvider = StateNotifierProvider.autoDispose.family<FeedDetailNotifier, FeedDetailState, int>((ref, feedId) {
  return FeedDetailNotifier(feedId: feedId, repository: ref.watch(feedRepositoryProvider));
});

class FeedDetailNotifier extends StateNotifier<FeedDetailState> {

  final FeedRepository repository;
  final int feedId;
  FeedDetailNotifier({required this.repository, required this.feedId,})
      : super(FeedDetailState.empty());

  Future<void> fetchFeed() async {
    logger.i('fetchFeed$feedId');
    state = state.copyWith(isLoading: true);
    final feed = await repository.getFeedById(feedId);
    state = state.copyWith(isLoading: false, feed: feed);
  }

  Future<void> saveShow({bool? onlyShowUnread, bool? showReadingTime}) async{
    final success = await repository.updateShow(feedId, onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime);
    if (success) {
      state = state.copyWith(feed: state.feed.copyWith(onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime));
    }
  }
}


class FeedDetailState {
  final Feed feed;
  final bool isLoading;

  const FeedDetailState({required this.feed, required this.isLoading,
  });

  factory FeedDetailState.empty() =>
      FeedDetailState(
        feed: Feed.empty,
        isLoading: false,
      );


  FeedDetailState copyWith({
    Feed? feed,
    bool? isLoading,
  }) {
    return FeedDetailState(
      feed: feed ?? this.feed,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}