


import 'package:follow_read/features/data/datasources/entry_dao.dart';
import 'package:follow_read/features/data/repositories/entry_repository.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_count_notifier.g.dart';


@riverpod
Future<int> feedUnread(ref, int feedId) async {
  final async = await ref.watch(unreadCountNotifierProvider.future);
  return async.feeds[feedId] ?? 0;
}

@riverpod
Future<int> folderUnread(ref, String feeds) async {
  if (feeds.isEmpty) return 0;
  final feedIds = feeds.split(",").toSet();
  UnreadCount async = await ref.watch(unreadCountNotifierProvider.future);

  return feedIds.fold<int>(0, (sum, id) {
    return sum + (async.feeds[int.parse(id)] ?? 0);
  });
}

//全局隐藏的时候count不对
@riverpod
Future<int> clusterUnread(ref, int clusterId) async {
  final async = await ref.watch(unreadCountNotifierProvider.future);
  return async.clusters[clusterId] ?? 0;
}


@riverpod
class UnreadCountNotifier extends _$UnreadCountNotifier {

  late EntryDao entryDao = ref.watch(entryDaoProvider);
  late EntryRepository entryRepository = ref.watch(entryRepositoryProvider);

  @override
  FutureOr<UnreadCount> build() async {
    final feeds = await entryDao.countFeed();
    final clusters = await entryRepository.countCluster();
    return UnreadCount(feeds: feeds, clusters: clusters);
  }
}

class UnreadCount {
  Map<int, int> feeds;
  Map<int, int> clusters;

  UnreadCount({
    this.feeds = const {},
    this.clusters = const {},
  });
}