


import 'package:follow_read/data/repositories/search_history_dao.dart';
import 'package:follow_read/di.dart';
import 'package:get/get.dart';

class SearchHistoryController extends GetxController {

  final BigInt id;
  final String type;
  final state = SearchState();
  final searchDao = SearchHistoryDao(Get.find<DBService>().db);
  SearchHistoryController(this.id, this.type);

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    state._loadingHistories.value = true;
    state.histories.value = await searchDao.getAll(metaId: "$type$id");
    state.histories.value = ['dsds', 'dsds'];
    state._loadingHistories.value = false;
  }

  Future<void> clear() async {
    await searchDao.deleteAll();
    await load();
  }

}

class SearchState {

  final histories = <String>[].obs;

  final _loadingHistories = false.obs;
  bool get loadingHistories => _loadingHistories.value;

}