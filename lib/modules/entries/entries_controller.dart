

import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/filter_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class EntriesController extends GetxController {
  final BigInt id;
  final String type;
  EntriesController(this.id, this.type);
  final state = EntriesState();
  final profile = Get.find<ProfileController>();
  final _feedService = Get.find<FeedService>();
  final _folderService = Get.find<FolderService>();
  final _filterService = Get.find<FilterService>();
  final _entryService = Get.find<EntryService>();


  @override
  void onReady() {
    super.onReady();
    init();
  }

  Future<void> init() async {
    if (state.isLoading) return;
    state._isLoading.value = true;

    state.meta = switch(type) {
      "e" => await _feedService.getFeed(id) ?? Feed(),
      "o" => await _folderService.getFolder(id) ?? Folder(),
      "i" => await _filterService.getFilter(id) ?? Filter(),
      _ => await _feedService.getFeed(id) ?? Feed(),
    };
    await Future.delayed(Duration(milliseconds: 200));
    final entries = await _entryService.entries(state.meta!, page: 1, size: state.size);
    state.addEntries(entries, reset: true);
    state._isLoading.value = false;
  }

  Future<void> nextPage() async {
    if (state.isLoadingMore) return;
    await Future.delayed(Duration(milliseconds: 500));
    state.isLoadingMore = true;
    final entries = await _entryService.entries(state.meta, page: state.page + 1, size: state.size);
    state.addEntries(entries);
    state.isLoadingMore = false;
  }

  Future<void> autoRead(BigInt entryId) async {
    if (profile.state.user.autoRead) {
      await read(entryId, status: EntryStatus.read);
    }
  }

  Future<void> read(BigInt entryId, {EntryStatus? status}) async {
    final entry = state.get(entryId);
    status = status ?? switch(entry.status) {
      EntryStatus.read => EntryStatus.unread,
      EntryStatus.unread => EntryStatus.read,
      _ => EntryStatus.read,
    };
    logger.i("$status   ${entry.status}");
    if (entry.status != status) {
      state.getObs(entryId).value = entry.copyWith(status: status);
      await _entryService.setEntryStatus([entryId], status);
    }
  }

  Future<void> changeMate({String? order}) async {

  }

//   Future<void> starred() async {
//     final entry = state.entry;
//     final success = await entryRepository.starred(entryId, !entry.starred);
//     if (success) {
//       entry.copyWith(starred: !entry.starred);
//       return;
//     }
//   }

}


class EntriesState {
  Meta meta = Feed();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  bool isLoadingMore = false;

  final _hasMore = false.obs;
  bool get hasMore => _hasMore.value;

  List<Rx<Entry>> entries = [];

  final _entriesLen = 0.obs;
  int get entriesLen => _entriesLen.value;

  int page = 0;
  int size = 20;

  Rx<Entry> getObs(BigInt id) => entries.firstWhere((e) => e.value.id == id);
  Entry get(BigInt id) => getObs(id).value;

  void addEntries(List<Entry> addList, {bool reset = false}){
    if (reset) {
      entries = addList.map((item) => item.obs).toList();
      page = 1;
    } else {
      entries = [...entries, ...addList.map((item) => item.obs)];
      page = page + 1;
    }
    _hasMore.value = addList.length >= size;
    _entriesLen.value = entries.length; //这里是有bug的，如果开始是10条，刷新之后还是10条，是不会重建的，但是这10条可能数据是变了的
  }

}