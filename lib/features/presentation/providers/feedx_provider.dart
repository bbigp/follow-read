

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/repositories/category_repository.dart';
import 'package:follow_read/features/data/repositories/cluster_repository.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/domain/models/feed.dart';

import 'app_container.dart';

class PageInfo<T> {
  final List<T> list;
  final int page;
  final int size;
  const PageInfo({required this.list, this.page = 1, this.size = 10});
}

class HomePageData {
  final List<Feed> feeds;
  final List<Category> folders;
  final List<Cluster> aists;
  const HomePageData({this.feeds = const [], this.folders = const [], this.aists = const []});
}

// final homeProvider = AsyncNotifierProvider.autoDispose<HomeNotifier, HomePageData>(
//   HomeNotifier.new,
// );

final homeProvider = Provider.autoDispose<HomePageData?>((ref) {
  final feeds = ref.watch(feedsProvider).value;
  final folders = ref.watch(foldersProvider).value;
  final aists = ref.watch(aistsProvider).value;
  if (feeds == null || folders == null || aists == null) return null;

  final root = folders.firstWhere((c) => c.title == "All", orElse: () => Category.empty);
  final Map<int, List<Feed>> folderFeedsMap = feeds.fold<Map<int, List<Feed>>>({}, (map, feed) {
    final cid = feed.categoryId;
    map.putIfAbsent(cid, () => []);
    map[cid]!.add(feed);
    return map;
  },);

  List<Category> f = [];
  for (final folder in folders) {
    if (folder.id == root.id){
      continue;
    }
    f.add(folder.copyWith(feeds: folderFeedsMap[folder.id] ?? []));
  }
  return HomePageData(feeds: folderFeedsMap[root.id] ?? [], folders: f, aists: aists);
});

// class HomeNotifier extends AutoDisposeAsyncNotifier<HomePageData> {
//   @override
//   FutureOr<HomePageData> build() {
//     final feedsAsync = ref.watch(feedsProvider);
//     final foldersAsync = ref.watch(foldersProvider);
//     final aistsAsync = ref.watch(aistsProvider);
//     if (feedsAsync.isLoading || foldersAsync.isLoading || aistsAsync.isLoading) {
//       return const AsyncLoading();
//     }
//
//
//     final root = folders.firstWhere((c) => c.title == "All", orElse: () => Category.empty);
//     final Map<int, List<Feed>> folderFeedsMap = feeds.fold<Map<int, List<Feed>>>({}, (map, feed) {
//       final cid = feed.categoryId;
//       map.putIfAbsent(cid, () => []);
//       map[cid]!.add(feed);
//       return map;
//     },);
//
//     List<Category> f = [];
//     for (final folder in folders) {
//       if (folder.id == root.id){
//         continue;
//       }
//       f.add(folder.copyWith(feeds: folderFeedsMap[folder.id] ?? []));
//     }
//     return HomePageData(feeds: folderFeedsMap[root.id] ?? [], folders: f, aists: aists);
//   }
//
// }


//FutureProvider 一次性 数据不缓存
//AsyncNotifierProvider  数据缓存  Provider暴漏出去，Notifier数据控制器

final feedsProvider = AsyncNotifierProvider.autoDispose<FeedsNotifier, List<Feed>>(
  FeedsNotifier.new,
);
final foldersProvider = AsyncNotifierProvider.autoDispose<FoldersNotifier, List<Category>>(
  FoldersNotifier.new
);
final aistsProvider = AsyncNotifierProvider.autoDispose<AistsNotifier, List<Cluster>>(
  AistsNotifier.new
);



class FeedsNotifier extends AutoDisposeAsyncNotifier<List<Feed>> {

  late final FeedRepository _feedRepository = ref.watch(feedRepositoryProvider);

  @override
  FutureOr<List<Feed>> build() async {
    final feeds = await _feedRepository.getFeeds();
    return feeds;
  }

}

class FoldersNotifier extends AutoDisposeAsyncNotifier<List<Category>> {
  late final CategoryRepository _categoryRepository = ref.watch(categoryRepositoryProvider);

  @override
  FutureOr<List<Category>> build() async {
    final categories = await _categoryRepository.getCategories();
    return categories;
  }
}

class AistsNotifier extends AutoDisposeAsyncNotifier<List<Cluster>> {
  late final ClusterRepository _clusterRepository = ref.watch(clusterRepositoryProvider);

  @override
  FutureOr<List<Cluster>> build() async {
    return await _clusterRepository.getAll();
  }
}




