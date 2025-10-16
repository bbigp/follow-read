

import 'dart:async';

import 'package:follow_read/data/event/entry_event.dart';
import 'package:follow_read/data/event/event_bus.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/data/model/page_state.dart';
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
      final entry = state.getRx(event.entryId);
      if (entry.value.isNull()) return;
      entry.value = entry.value.copyWith(status: event.status);
    });
    _entrySub = eventBus.on<EntryChangedEvent>().listen((event){
      final entry = state.getRx(event.entryId);
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
    state.setIsLoading(true);

    state._meta.value = switch(type) {
      "e" => await _feedService.getFeed(id: id) ?? Feed(),
      "o" => await _folderService.getFolder(id) ?? Folder(),
      "i" => await _filterService.getFilter(id) ?? Filter(),
      _ => await _feedService.getFeed(id: id) ?? Feed(),
    };
    await Future.delayed(Duration(milliseconds: 200));
    final entries = await _entryService.entries(state.meta, page: 1, size: state.size);
    state.addItems(entries.map((e) => e.obs).toList(), reset: true);
    state.setIsLoading(false);
  }

  Future<void> nextPage() async {
    if (state.isLoadingMore) return;
    state.isLoadingMore = true;
    await Future.delayed(Duration(milliseconds: 500));
    final entries = await _entryService.entries(state.meta, page: state.page + 1, size: state.size);
    state.addItems(entries.map((e) => e.obs).toList());
    state.isLoadingMore = false;
  }

  Future<void> autoRead(Entry entry) async {
    //已读状态进入页面 设置未读 退出之后 自动已读没生效
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


class EntriesState extends PageState<Rx<Entry>> {
  final Rx<Meta?> _meta = Rx<Meta?>(null);
  Meta get meta => _meta.value ?? Feed();
  void setMeta(Meta? value) => _meta.value = value;

  Rx<Entry> getRx(BigInt id) => items.firstWhere((e) => e.value.id == id,
      orElse: () => Entry.empty.obs
  );
  Entry get(BigInt id) => getRx(id).value;

}