// import 'dart:async';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:follow_read/features/data/repositories/feed_repository.dart';
// import 'package:follow_read/features/domain/models/feed.dart';
//
// import 'app_container.dart';
//
// final feedsProvider = AsyncNotifierProvider.autoDispose<FeedsNotifier, List<Feed>>(
//   FeedsNotifier.new,
// );
//
// class FeedsNotifier extends AutoDisposeAsyncNotifier<List<Feed>> {
//
//   late final FeedRepository _feedRepository = ref.watch(feedRepositoryProvider);
//
//   @override
//   FutureOr<List<Feed>> build() async {
//     final feeds = await _feedRepository.getFeeds();
//     return feeds;
//   }
//
//   Feed get(int id) {
//     final index = state.requireValue.indexWhere((f) => f.id == id);
//     return state.requireValue[index];
//   }
//
// }