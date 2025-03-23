
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/feed_repository.dart';
import '../../domain/models/feed.dart';
import 'app_container.dart';

final feedDetailProvider = StateNotifierProvider<FeedDetailNotifier, FeedDetailState>((ref) {
  return FeedDetailNotifier(repository: ref.watch(feedRepositoryProvider));
});

class FeedDetailNotifier extends StateNotifier<FeedDetailState> {

  final FeedRepository _repository;
  FeedDetailNotifier({required FeedRepository repository})
      : _repository = repository, super(FeedDetailState.empty());

  Future<void> fetchFeed(int feedId) async {
    state = state.copyWith(isLoading: true, feedId: feedId);
    final feed = await _repository.getFeedById(state.feedId);
    state = state.copyWith(isLoading: false, feed: feed);
  }
}


class FeedDetailState {
  final int feedId;
  final Feed feed;
  final bool isLoading;

  const FeedDetailState({required this.feed, required this.isLoading,
    required this.feedId,
  });

  factory FeedDetailState.empty() =>
      FeedDetailState(
        feedId: 0,
        feed: Feed.empty,
        isLoading: false,
      );


  FeedDetailState copyWith({
    Feed? feed,
    bool? isLoading,
    int? feedId,
  }) {
    return FeedDetailState(
      feed: feed ?? this.feed,
      isLoading: isLoading ?? this.isLoading,
      feedId: feedId ?? this.feedId,
    );
  }
}