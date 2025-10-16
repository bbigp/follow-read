


import 'dart:async';

import 'package:follow_read/data/event/entry_event.dart';
import 'package:follow_read/data/event/event_bus.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/repositories/search_history_dao.dart';
import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/di.dart';
import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchHistoryController extends GetxController {

  // final BigInt id;
  // final String type;
  final state = SearchState();
  final searchDao = SearchHistoryDao(Get.find<DBService>().db);
  final entryService = Get.find<EntryService>();
  final entriesPage = Get.find<EntriesController>();
  final profilePage = Get.find<ProfileController>();
  final eventBus = Get.find<EventBusService>().bus;
  StreamSubscription? _subscription;
  StreamSubscription? _entrySub;
  SearchHistoryController();


  @override
  void onInit() {
    super.onInit();
    _subscription = eventBus.on<EntryStatusEvent>().listen((event){
      final entry = state.getEntryById(event.entryId);
      if (entry.value.isNull()) return;
      entry.value = entry.value.copyWith(status: event.status);
    });
    _entrySub = eventBus.on<EntryChangedEvent>().listen((event){
      final entry = state.getEntryById(event.entryId);
      if (entry.value.isNull()) return;
      if (event.starred != null) entry.value = entry.value.copyWith(starred: event.starred);
    });
  }

  @override
  void onReady() {
    super.onReady();
    load();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    _entrySub?.cancel();
    super.onClose();
  }

  Future<void> load() async {
    state._loadingHistories.value = true;
    state.histories.value = await searchDao.getAll(metaId: entriesPage.metaId);
    state._loadingHistories.value = false;
  }

  Future<void> clear() async {
    await searchDao.deleteAll();
    await load();
  }

  Future<void> loadEntries(String word) async {
    state._word.value = word;
    state._loadingEntries.value = true;
    await searchDao.save(word, entriesPage.metaId, profilePage.state.user.id);
    final entries = await entryService.entries(entriesPage.state.meta,
        page: 1, size: state.size, search: state.word
    );
    state.addEntries(entries, reset: true);
    state._loadingEntries.value = false;
  }

  Future<void> nextPage() async {
    state.isLoadingMore = true;
    final page = state.page + 1;
    final entries = await entryService.entries(entriesPage.state.meta,
        page: page, size: state.size, search: state.word
    );
    state.addEntries(entries);
    state.isLoadingMore = false;
  }

  Future<void> clearEntries() async {
    await load();
    state._word.value = "";
    state._loadingEntries.value = false;
    state.entries = [];
    state._page.value = 0;
    state._hasMore.value = false;
    state.isLoadingMore = false;
  }

}

class SearchState {

  final _word = "".obs;
  String get word => _word.value;

  final _loadingEntries = false.obs;
  bool get loadingEntries => _loadingEntries.value;
  List<Rx<Entry>> entries = [];
  final _page = 0.obs;
  int get page => _page.value;
  int size = 20;
  final _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  bool isLoadingMore = false;
  void addEntries(List<Entry> addList, {bool reset = false}){
    if (reset) {
      entries = addList.map((item) => item.obs).toList();
      _page.value = 1;
    } else {
      entries = [...entries, ...addList.map((item) => item.obs)];
      _page.value = page + 1;
    }
    _hasMore.value = addList.length >= size;
  }

  Entry get(BigInt id) => entries.firstWhere((e) => e.value.id == id,
      orElse: () => Entry.empty.obs
  ).value;

  final histories = <String>[].obs;
  final _loadingHistories = false.obs;
  bool get loadingHistories => _loadingHistories.value;

  Rx<Entry> getEntryById(BigInt id) => entries.firstWhere((e) => e.value.id == id,
      orElse: () => Entry.empty.obs
  );

}