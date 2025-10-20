

import 'package:follow_read/data/model/entry.dart';
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

  final _isReaderMode = false.obs;
  bool get isReaderMode => _isReaderMode.value;
  final _hasReadableContent = false.obs;
  bool get hasReadableContent => _hasReadableContent.value;

  EntriesState state = EntriesState();

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<SearchHistoryController>()) {
      state = Get.find<SearchHistoryController>().state;
    } else if (Get.isRegistered<EntriesController>()){
      state = Get.find<EntriesController>().state;
    }
    _hasReadableContent.value = get().readableContent.isNotEmpty;
    _isReaderMode.value = hasReadableContent;
  }

  @override
  void onReady() {
    super.onReady();
    nextEntryId();
  }

  void changeReaderMode() {
    _isReaderMode.value = !_isReaderMode.value;
  }

  Entry get() => state.get(id);

  Future<void> saveReadableContent({String readableContent = '', String summary = "",
    String leadImageUrl = "",
  }) async {
    state.getRx(id).value = state.get(id).copyWith(readableContent: readableContent,
      summary: summary, leadImageUrl: leadImageUrl,
    );
    _hasReadableContent.value = get().readableContent.isNotEmpty;
    await _entryService.updateById(id, readableContent: readableContent, summary: summary,
      leadImageUrl: leadImageUrl,
    );
  }

  Future<void> nextEntryId() async {
    await _calculateNextEntryId(state);
  }

  Future<void> _calculateNextEntryId(EntriesState state) async {
    if (state.items.isEmpty) return;
    final currentIndex = state.items.indexWhere((e) => e.value.id == id);
    if (currentIndex == -1) return; //-1 表示未找到
    if (currentIndex == state.items.length - 1 ) {//length - 1 表示它是最后一个元素
      if (!state.hasMore) return;
      //todo 这里加载更多的方法不对，搜索页面和文章列表页面进入详情 加载更多用的不是同一个方法，搜索要带word的
      final entries = await _entryService.entries(state.meta, page: state.page + 1, size: state.size);
      state.addItems(entries.map((e) => e.obs).toList());
      if (currentIndex + 1 >= state.items.length) {
        return;
      }
    }
    _nextId.value = state.items[currentIndex + 1].value.id;
  }

}