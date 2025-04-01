
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/datasources/category_dao.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/listx.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../data/repositories/category_repository.dart';
import '../../domain/models/feed.dart';

final feedLoadingProvider = StateNotifierProvider<HomePageNotifier, HomePageState>((ref) {
  return HomePageNotifier(
    feedRepository: ref.read(feedRepositoryProvider),
      categoryRepository: ref.read(categoryRepository),
  );
});

class HomePageNotifier extends StateNotifier<HomePageState> {

  final FeedRepository feedRepository;
  final CategoryRepository categoryRepository;

  HomePageNotifier({
    required this.feedRepository,
    required this.categoryRepository,
  }) : super(HomePageState.empty);

  Future<void> loadingData() async{
    final feeds = await feedRepository.getFeeds();
    final Map<int, List<Feed>> feedsByCid = feeds.fold<Map<int, List<Feed>>>(
      {}, // 初始空Map
          (map, feed) {
        // 获取当前feed的cid
        final cid = feed.categoryId;

        // 若map中不存在该cid，初始化空列表
        map.putIfAbsent(cid, () => []);

        // 将feed添加到对应cid的列表中
        map[cid]!.add(feed);

        return map;
      },
    );


    final categories = await categoryRepository.getCategories();
  }

}

class HomePageState {

  final List<Listx> listx;
  final List<Feed> feeds;

  const HomePageState({
    this.listx = const <Listx>[],  this.feeds = const<Feed>[],
  });
  static const empty = HomePageState();


}

