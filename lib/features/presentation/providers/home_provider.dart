import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/feed.dart';

import 'aists_provider.dart';
import 'feeds_provider.dart';
import 'folders_provider.dart';

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
