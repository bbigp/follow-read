

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/listx.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../../config/svgicons.dart';
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
    final all = [...firstPage(), ...feeds.map((item) => UiItem(type: ViewType.feedItem, content: item))];
    state = state.copyWith(items: all);
  }

  List<UiItem> firstPage(){
    final all = Listx(title: '全部', unread: 90, svgicon: Svgicons.all);
    final read = Listx(title: '近期已读', svgicon: Svgicons.markRead,);
    final star = Listx(title: '星标', svgicon: Svgicons.addCollection,);
    final unread = Listx(title: '未读', svgicon: Svgicons.markUnread,);
    final today = Listx(title: '今日', svgicon: Svgicons.today,);

    return [
      UiItem(type: ViewType.groupTitleItem, content: TitleUiData(title: '智能视图')),
      UiItem(type: ViewType.listItem, content: all),
      UiItem(type: ViewType.listItem, content: read),
      UiItem(type: ViewType.listItem, content: star),
      UiItem(type: ViewType.listItem, content: unread),
      UiItem(type: ViewType.listItem, content: today),
      UiItem(type: ViewType.divider32, content: EmptyUiData()),
      UiItem(type: ViewType.groupTitleItem, content: TitleUiData(title: '订阅源')),
    ];
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
