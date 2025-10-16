
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class PageState<T> {

  final _page = 0.obs;
  int get page => _page.value;
  // void setPage(int value) => _page.value = value;

  int size = 20;
  bool isLoadingMore = false;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  void setIsLoading(bool value) => _isLoading.value = value;


  final _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  // void setHasMore(bool value) => _hasMore.value = value;

  final items = <T>[].obs;

  void addItems(List<T> addList, {bool reset = false}){
    if (reset) {
      items.value = addList;
      _page.value = 1;
    } else {
      items.addAll(addList);
      _page.value = page + 1;
    }
    _hasMore.value = addList.length >= size;
  }


  void clear() {
    _isLoading.value = false;
    items.value = [];
    _page.value = 0;
    _hasMore.value = false;
    isLoadingMore = false;
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