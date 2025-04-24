


import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/data/datasources/entry_dao.dart';
import 'package:follow_read/features/domain/models/tile.dart';
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
  final feedIds = feeds.split(",").toSet().toList();
  final async = await ref.watch(unreadCountNotifierProvider.future);

  int unread = 0;
  feedIds.map((id) => unread + (async.feeds[id] ?? 0));
  return unread;
}


@riverpod
class UnreadCountNotifier extends _$UnreadCountNotifier {

  late EntryDao entryDao = ref.watch(entryDaoProvider);

  @override
  FutureOr<UnreadCount> build() async {
    final feeds = await entryDao.countFeed();
    return UnreadCount(feeds: feeds);
  }
}

class UnreadCount {
  Map<int, int> feeds;

  UnreadCount({
    this.feeds = const {},
  });
}