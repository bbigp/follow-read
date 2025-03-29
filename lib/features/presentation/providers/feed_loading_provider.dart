

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../data/repositories/feed_repository.dart';
import '../../domain/models/ui_item.dart';

final feedLoadingProvider = StateNotifierProvider<FeedLoadingNotifier, FeedsState>((ref) {
  return FeedLoadingNotifier(feedRepository: ref.watch(feedRepositoryProvider));
});

class FeedLoadingNotifier extends StateNotifier<FeedsState> {
  final FeedRepository _feedRepository;
  FeedLoadingNotifier({required FeedRepository feedRepository}) :
        _feedRepository = feedRepository,
        super(FeedsState.empty);


  Future<void> refresh() async {
    state = state.copyWith(isSyncing: true);
    final result = await _feedRepository.refreshFeeds();
    await _feedRepository.refreshFeedCounter();
    result.fold((error) {
      state = state.copyWith(isSyncing: false);
      //toast提示同步失败
    }, (feeds) async {
      state = state.copyWith(isSyncing: false);
      await getFeeds();
    });
  }

  Future<void> getFeeds() async {
    final feeds = await _feedRepository.getFeeds();
    final all = [...feeds.map((item) => UiItem(type: ViewType.feedItem, content: item))];
    state = state.copyWith(items: all);
  }

}

class FeedsState {
  final bool isSyncing;
  final List<UiItem> items;

  const FeedsState({
    required this.isSyncing,
    required this.items,
  });

  static const empty = FeedsState(
    isSyncing: false,
    items: <UiItem>[],
  );


  FeedsState copyWith({
    bool? isSyncing,
    List<UiItem>? items
  }) {
    return FeedsState(
      isSyncing: isSyncing ?? this.isSyncing,
      items: items ?? this.items,
    );
  }
}
