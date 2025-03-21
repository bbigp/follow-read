

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/feed.dart';
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
    final all = Feed(
      id: 0,
      title: '全部',
      userId: 0,
      feedUrl: '',
      siteUrl: '',
      viewType: ViewType.listItem,
      unread: 90, read: 0,
    );
    final read = Feed(
      id: 0,
      title: '近期已读',
      userId: 0,
      feedUrl: '',
      siteUrl: '',
      viewType: ViewType.listItem,
      iconData: Icons.history,
    );
    final star = Feed(
      id: 0,
      title: '星标',
      userId: 0,
      feedUrl: '',
      siteUrl: '',
      viewType: ViewType.listItem,
      iconData: Icons.star_border,
    );
    final unread = Feed(
      id: 0,
      title: '未读',
      userId: 0,
      feedUrl: '',
      siteUrl: '',
      viewType: ViewType.listItem,
      iconData: Icons.circle_outlined,
    );
    final today = Feed(
      id: 0,
      title: '今日',
      userId: 0,
      feedUrl: '',
      siteUrl: '',
      viewType: ViewType.listItem,
      iconData: Icons.calendar_today_outlined,
    );
    final smartview = Feed(
      id: 0,
      title: '智能视图',
      userId: 0,
      feedUrl: '',
      siteUrl: '',
      viewType: ViewType.groupTitleItem,
    );
    final feed = Feed(
      id: 0,
      title: '订阅源',
      userId: 0,
      feedUrl: '',
      siteUrl: '',
      viewType: ViewType.groupTitleItem,
    );
    final feeds = await _feedRepository.getFeeds();
    feeds.insert(0, feed);
    feeds.insert(0, Feed(id: 0, userId: 0, feedUrl: '', siteUrl: '', title: '', viewType: ViewType.divider32));
    feeds.insert(0, today);
    feeds.insert(0, unread);
    feeds.insert(0, star);
    feeds.insert(0, read);
    feeds.insert(0, all);
    feeds.insert(0, smartview);
    state = state.copyWith(feeds: feeds);
  }
}

class FeedsState {
  final bool isSyncing;
  final List<Feed> feeds;

  const FeedsState({
    required this.isSyncing,
    required this.feeds,
  });

  static const empty = FeedsState(
    isSyncing: false,
    feeds: <Feed>[],
  );


  FeedsState copyWith({
    bool? isSyncing,
    List<Feed>? feeds
  }) {
    return FeedsState(
      isSyncing: isSyncing ?? this.isSyncing,
      feeds: feeds ?? this.feeds,
    );
  }
}
