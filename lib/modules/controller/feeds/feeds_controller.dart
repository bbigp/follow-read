// import 'package:follow_read/features/presentation/providers/app_container.dart';
// import 'package:get/get.dart';
//
// import 'feeds_state.dart';
//
// class FeedsController extends GetxController {
//   final FeedsState state = FeedsState();
//
//   @override
//   void onReady() {
//     super.onReady();
//     _load();
//   }
//
//   Future<void> _load() async {
//     state.isLoading = true;
//     final feeds = await feedRepository.getFeeds();
//     state.feeds.value = feeds;
//     // state.feeds.value = [...feeds, ...feeds, ...feeds, ...feeds,];
//     state.isLoading = false;
//   }
// }
