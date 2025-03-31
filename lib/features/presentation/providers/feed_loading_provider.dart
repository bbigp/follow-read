

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/models/entry_page_response.dart';
import 'package:follow_read/features/data/repositories/entry_repository.dart';
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
    final feeds = await _feedRepository.getFeeds();
    final readCount = await _entryRepository.countRead("read");
    final unreadCount = await _entryRepository.countRead("unread");
    final totalCount = await _entryRepository.count();
    final starredCount = await _entryRepository.countStarred();
    final todayCount = await _entryRepository.countToday();
    state = state.copyWith(feeds: feeds, readCount: readCount, unreadCount: unreadCount,
        totalCount: totalCount, starredCount: starredCount, todayCount: todayCount,
    );
  }

}

class FeedsState {
  final bool isSyncing;
  final List<Feed> feeds;
  final int readCount;
  final int unreadCount;
  final int totalCount;
  final int starredCount;
  final int todayCount;

  const FeedsState({
    required this.isSyncing,
    required this.feeds,
    this.readCount = 0,
    this.unreadCount = 0,
    this.totalCount = 0,
    this.starredCount = 0,
    this.todayCount = 0,
  });

  static const empty = FeedsState(
    isSyncing: false,
    feeds: <Feed>[],
  );


  FeedsState copyWith({
    bool? isSyncing,
    List<Feed>? feeds,
    int? readCount,
    int? unreadCount,
    int? totalCount,
    int? starredCount,
    int? todayCount,
  }) {
    return FeedsState(
      isSyncing: isSyncing ?? this.isSyncing,
      feeds: feeds ?? this.feeds,
        readCount: readCount ?? this.readCount,
        unreadCount: unreadCount ?? this.unreadCount,
        totalCount: totalCount ?? this.totalCount,
        starredCount: starredCount ?? this.starredCount,
        todayCount: todayCount ?? this.todayCount,
    );
  }
}
