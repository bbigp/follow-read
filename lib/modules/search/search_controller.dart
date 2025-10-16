


import 'dart:async';

import 'package:follow_read/data/event/entry_event.dart';
import 'package:follow_read/data/event/event_bus.dart';
import 'package:follow_read/data/repositories/search_history_dao.dart';
import 'package:follow_read/data/services/entry_service.dart';
import 'package:follow_read/di.dart';
import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class SearchHistoryController extends GetxController {

  final state = SearchState();
  final searchDao = SearchHistoryDao(Get.find<DBService>().db);
  final entryService = Get.find<EntryService>();
  final entriesPage = Get.find<EntriesController>();
  final profilePage = Get.find<ProfileController>();
  final eventBus = Get.find<EventBusService>().bus;
  StreamSubscription? _subscription;
  StreamSubscription? _entrySub;

  @override
  void onInit() {
    super.onInit();
    state.setMeta(entriesPage.state.meta);
    _subscription = eventBus.on<EntryStatusEvent>().listen((event){
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
    state.histories.value = await searchDao.getAll(metaId: state.meta.metaId);
    state._loadingHistories.value = false;
  }

  Future<void> clear() async {
    await searchDao.deleteAll();
    await load();
  }

  Future<void> loadEntries(String word) async {
    state._word.value = word;
    if (state.isLoading) return;
    state.setIsLoading(true);
    await searchDao.save(word, state.meta.metaId, profilePage.state.user.id);
    final entries = await entryService.entries(state.meta, page: 1,
        size: state.size, search: state.word
    );
    state.addItems(entries.map((e) => e.obs).toList(), reset: true);
    state.setIsLoading(false);
  }

  Future<void> nextPage() async {
    if (state.isLoadingMore) return;
    state.isLoadingMore = true;
    final page = state.page + 1;
    await Future.delayed(Duration(milliseconds: 350));
    final entries = await entryService.entries(state.meta, page: page,
        size: state.size, search: state.word
    );
    state.addItems(entries.map((e) => e.obs).toList());
    state.isLoadingMore = false;
  }

  Future<void> clearEntries() async {
    await load();
    state._word.value = "";
    state.clear();
  }

}

class SearchState extends EntriesState {

  final _word = "".obs;
  String get word => _word.value;

  final histories = <String>[].obs;
  final _loadingHistories = false.obs;
  bool get loadingHistories => _loadingHistories.value;
}