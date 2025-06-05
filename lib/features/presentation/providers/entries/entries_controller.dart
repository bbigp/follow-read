import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:get/get.dart';

import 'entries_state.dart';
import 'meta_data.dart';

class EntriesController extends GetxController {
  final EntriesState state = EntriesState();

  final MetaDatax metaDatax;
  EntriesController(this.metaDatax);

  @override
  void onReady() {
    super.onReady();
    init();
  }

  Future<void> init() async {
    if (state.isLoading) return;
    await Future.delayed(Duration(milliseconds: 200));
    state.meta = await metaDatax.getMeta();
    state.isLoading = true;
    final entries = await entryRepository.fetchEntries(1, state.size, state.meta.toBuilder());
    state.addNextPage(entries, nextPage: 1);
    state.isLoading = false;
  }

  void nextPage() async {
    if (state.isLoadingMore) return;
    await Future.delayed(Duration(milliseconds: 500));
    state.isLoadingMore = true;
    final entries = await entryRepository.fetchEntries(state.page + 1, state.size, state.meta.toBuilder());
    state.addNextPage(entries);
    state.isLoadingMore = false;
  }
}
