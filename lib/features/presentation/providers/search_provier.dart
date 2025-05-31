

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';


final searchHistoriesProvider = AsyncNotifierProvider.autoDispose<SearchHistoriesNotifier, List<String>>(
    SearchHistoriesNotifier.new,
);

class SearchHistoriesNotifier extends AutoDisposeAsyncNotifier<List<String>> {

  late final _searchDao = ref.watch(searchDaoProvider);

  @override
  FutureOr<List<String>> build() async {
    return await _searchDao.getAll();
  }

  void clear() {
    _searchDao.deleteData();
    state = AsyncData([]);
  }

}