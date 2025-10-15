

import 'dart:async';

import 'package:follow_read/data/event/entry_event.dart';
import 'package:follow_read/data/event/event_bus.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/repositories/pending_change_dao.dart';
import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/data/services/feed_service.dart';
import 'package:follow_read/data/services/filter_service.dart';
import 'package:follow_read/data/services/folder_service.dart';
import 'package:follow_read/di.dart';
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
  final pendingChangeDao = PendingChangeDao(Get.find<DBService>().db);
  final eventBus = Get.find<EventBusService>().bus;
  StreamSubscription? _readStatusSub;
  StreamSubscription? _entrySub;

  String get metaId => "$type$id";

  @override
  void onInit() {
    super.onInit();
    _readStatusSub = eventBus.on<EntryStatusEvent>().listen((event){
      final entry = state.getObs(event.entryId);
      if (entry.value.isNull()) return;
      entry.value = entry.value.copyWith(status: event.status);
    });
    _entrySub = eventBus.on<EntryChangedEvent>().listen((event){
      final entry = state.getObs(event.entryId);
      if (entry.value.isNull()) return;
      if (event.starred != null) entry.value = entry.value.copyWith(starred: event.starred);
    });
  }

  @override
  void onReady() {
    super.onReady();
    init();
  }

  @override
  void onClose() {
    _readStatusSub?.cancel();
    _entrySub?.cancel();
    super.onClose();
  }

  Future<void> init() async {
    if (state.isLoading) return;
    state._isLoading.value = true;

    state._meta.value = switch(type) {
      "e" => await _feedService.getFeed(id: id) ?? Feed(),
      "o" => await _folderService.getFolder(id) ?? Folder(),
      "i" => await _filterService.getFilter(id) ?? Filter(),
      _ => await _feedService.getFeed(id: id) ?? Feed(),
    };
    await Future.delayed(Duration(milliseconds: 200));
    final entries = await _entryService.entries(state.meta, page: 1, size: state.size);
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

  Future<void> autoRead(Entry entry) async {
    if (profile.state.user.autoRead && entry.status != EntryStatus.read) {
      await read(entry, status: EntryStatus.read);
    }
  }

  Future<void> read(Entry entry, {EntryStatus? status}) async {
    final entryId = entry.id;
    status = status ?? (entry.isUnread ? EntryStatus.read : EntryStatus.unread);
    await _entryService.setEntryStatus([entryId], profile.state.user.id, status: status);
    eventBus.fire(EntryStatusEvent(status: status, entryId: entryId,
      feedId: entry.feed.id,
      folderId: entry.feed.folderId,
    ));
  }

  Future<void> changeMate({String? order, bool? unreadOnly}) async {
    if (type == "e") {
      await _feedService.saveLocal(id, unreadOnly: unreadOnly, orderx: order);
    }
    await init();
  }

  Future<void> starred(Entry entry) async {
    final entryId = entry.id;
    await _entryService.setEntryStatus([entryId], profile.state.user.id, starred: !entry.starred);
    eventBus.fire(EntryChangedEvent(entryId: entryId, starred: !entry.starred));
  }

}


class EntriesState {
  final Rx<Meta?> _meta = Rx<Meta?>(null);
  Meta get meta => _meta.value ?? Feed();

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

  Rx<Entry> getObs(BigInt id) => entries.firstWhere((e) => e.value.id == id,
      orElse: () => Entry.empty.obs
  );
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