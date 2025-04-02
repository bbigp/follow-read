

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/smart_list_count.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../data/datasources/entry_dao.dart';
import '../../data/repositories/feed_repository.dart';
import '../../domain/models/feed.dart';

final feedLoadingProvider = StateNotifierProvider<FeedLoadingNotifier, FeedsState>((ref) {
  return FeedLoadingNotifier(
      feedRepository: ref.watch(feedRepositoryProvider),
      entryRepository: ref.watch(entryDaoProvider),
  );
});

class FeedLoadingNotifier extends StateNotifier<FeedsState> {
  final FeedRepository _feedRepository;
  final EntryDao _entryRepository;
  FeedLoadingNotifier({required FeedRepository feedRepository,
  required EntryDao entryRepository}) :
        _feedRepository = feedRepository, _entryRepository = entryRepository,
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
    // final feeds = await _feedRepository.getFeeds();
    final smartCount = await _entryRepository.countSmartList();
    state = state.copyWith(feeds: [], smartCount: smartCount,);
  }

}

class FeedsState {
  final bool isSyncing;
  final List<Feed> feeds;
  final SmartListCount smartCount;

  const FeedsState({
    required this.isSyncing,
    required this.feeds,
    this.smartCount = const SmartListCount(),
  });

  static const empty = FeedsState(
    isSyncing: false,
    feeds: <Feed>[],
  );


  FeedsState copyWith({
    bool? isSyncing,
    List<Feed>? feeds,
    SmartListCount? smartCount,
  }) {
    return FeedsState(
      isSyncing: isSyncing ?? this.isSyncing,
      feeds: feeds ?? this.feeds,
      smartCount: smartCount ?? this.smartCount,
    );
  }
}
