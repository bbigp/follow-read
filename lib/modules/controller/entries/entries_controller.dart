// import 'package:follow_read/features/presentation/providers/app_container.dart';
// import 'package:follow_read/modules/pages/entries/meta_data.dart';
// import 'package:get/get.dart';
//
// import 'entries_state.dart';
//
//
// class EntriesController extends GetxController {
//   final EntriesState state = EntriesState();
//
//   final MetaDatax metaDatax;
//   EntriesController(this.metaDatax);
//
//   @override
//   void onReady() {
//     super.onReady();
//     init();
//   }
//
//   Future<void> init() async {
//     if (state.isLoading) return;
//     state.isLoading = true;
//     await Future.delayed(Duration(milliseconds: 200));
//     state.meta = await metaDatax.getMeta();
//     final entries = await entryRepository.fetchEntries(1, state.size, state.meta.toBuilder());
//     state.addNextPage(entries, nextPage: 1);
//     state.isLoading = false;
//   }
//
//   void nextPage() async {
//     if (state.isLoadingMore) return;
//     await Future.delayed(Duration(milliseconds: 500));
//     state.isLoadingMore = true;
//     final entries = await entryRepository.fetchEntries(state.page + 1, state.size, state.meta.toBuilder());
//     state.addNextPage(entries);
//     state.isLoadingMore = false;
//   }
// }
