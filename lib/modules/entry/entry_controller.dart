

import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/data/services/memory_cache_controller.dart';
import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:get/get.dart';

class EntryController extends GetxController {
  final BigInt id;
  EntryController(this.id);
  final state = EntryPageState();
  final _entryService = Get.find<EntryService>();
  final _cache = Get.find<MemoryCacheController>();
  final _entries = Get.find<EntriesController>();

  @override
  void onReady() {
    super.onReady();
    load();
  }



  Future<void> load() async {
    // state._entry = _entries.get(id);
  }



}


class EntryPageState{

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // var _entry = Entry.empty.obs;
  // Entry get entry => _entry.value;

}