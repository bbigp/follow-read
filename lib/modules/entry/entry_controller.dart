

import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:follow_read/modules/search/search_controller.dart';
import 'package:get/get.dart';

class EntryController extends GetxController {

  final BigInt id;
  EntryController(this.id);
  final _entryService = Get.find<EntryService>();

  final _nextId = Rx<BigInt?>(null);
  BigInt? get nextId => _nextId.value;

  @override
  void onReady() {
    super.onReady();
    nextEntryId();
  }


  //搜索页面 下一个用的是文章列表也数据
  Future<void> nextEntryId() async {
    dynamic state;
    if (Get.isRegistered<SearchHistoryController>()) {
      state = Get.find<SearchHistoryController>().state;
    } else if (Get.isRegistered<EntriesController>()) {
      state = Get.find<EntriesController>().state;
    } else {
      return;
    }
    await _calculateNextEntryId(state);
  }

  Future<void> _calculateNextEntryId(dynamic state) async {
    if (state.entries.isEmpty) return;
    final currentIndex = state.entries.indexWhere((e) => e.value.id == id);
    if (currentIndex == -1) return; //-1 表示未找到
    if (currentIndex == state.entries.length - 1 ) {//length - 1 表示它是最后一个元素
      if (!state.hasMore) return;
      final entries = await _entryService.entries(state.meta, page: state.page + 1, size: state.size);
      state.addEntries(entries);
      if (currentIndex + 1 >= state.entries.length) {
        return;
      }
    }
    _nextId.value = state.entries[currentIndex + 1].value.id;
  }

}

abstract class NextIdState<T> {
  Meta get meta;
  int get page;
  int get size;
  List<T> get entries;
  bool get hasMore;
  void addEntries(List<Entry> addList, {bool reset = false});
}