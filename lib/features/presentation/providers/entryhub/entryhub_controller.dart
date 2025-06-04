import 'package:follow_read/features/domain/cases/base.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:get/get.dart';

import 'entryhub_state.dart';

class EntryhubController extends GetxController {
  final EntryhubState state = EntryhubState();

  final MetaDatax metaDatax;
  EntryhubController(this.metaDatax);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    if (state.isLoading) return;
    state.isLoading = true;
    final builder = metaDatax.getMeta().toBuilder();
    final entries = await entryRepository.fetchEntries(1, state.size, builder);
    state.addNextPage(entries, nextPage: 1);
    state.isLoading = false;
  }

  void nextPage() async {
    if (state.isLoadingMore) return;
    state.isLoadingMore = true;
    final builder = metaDatax.getMeta().toBuilder();
    final entries = await entryRepository.fetchEntries(state.page + 1, state.size, builder);
    state.addNextPage(entries);
    state.isLoadingMore = false;
  }
}
