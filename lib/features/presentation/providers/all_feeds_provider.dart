//
//
//
// import 'dart:async';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:follow_read/features/domain/models/feed.dart';
//
// import '../../data/repositories/feed_repository.dart';
// import 'app_container.dart';
//
// final allFeedsProvider = AsyncNotifierProvider.autoDispose<AllFeedsNotifier, List<Feed>>(
//   AllFeedsNotifier.new,
// );
//
// class AllFeedsNotifier extends AutoDisposeAsyncNotifier<List<Feed>> {
//
//   late final FeedRepository _feedRepository = ref.watch(feedRepositoryProvider);
//
//   @override
//   FutureOr<List<Feed>> build() async {
//     return await _feedRepository.getFeeds(showAll: true);
//   }
//
// }