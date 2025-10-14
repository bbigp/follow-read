
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class PageState<T> {

  int page = 0;
  int size = 20;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  bool isLoadingMore = false;
  final _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  final items = <T>[].obs;

  void addItems(List<T> addList, {bool reset = false}){
    if (reset) {
      items.value = addList;
      page = 1;
    } else {
      items.addAll(addList);
      page = page + 1;
    }
    _hasMore.value = addList.length >= size;
  }
}

abstract class PagedController<T> extends GetxController {
  PageState<T> get state;

  Future<List<T>> fetchData(int page, int size);

  Future<void> _runPageOperation({bool isInitialLoad = false}) async {
    final int targetPage = isInitialLoad ? 1 : state.page + 1;
    if (isInitialLoad) {
      if (state.isLoading) return;
      state._isLoading.value = true;
    } else {
      if (state.isLoadingMore) return;
      state.isLoadingMore = true;
    }

    try {
      final items = await fetchData(targetPage, state.size);
      state.addItems(items, reset: isInitialLoad);
    } catch (e) {
      debugPrint('Pagination error: $e');
    } finally {
      state._isLoading.value = false;
      state.isLoadingMore = false;
    }
  }

  Future<void> load() async {
    return _runPageOperation(isInitialLoad: true);
  }
  void nextPage() {
    if (state.hasMore) {
      _runPageOperation(isInitialLoad: false);
    }
  }
}