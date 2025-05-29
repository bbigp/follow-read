import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/repositories/category_repository.dart';
import 'package:follow_read/features/domain/models/folder.dart';

import 'app_container.dart';

final foldersProvider = AsyncNotifierProvider.autoDispose<FoldersNotifier, List<Category>>(
    FoldersNotifier.new
);


class FoldersNotifier extends AutoDisposeAsyncNotifier<List<Category>> {
  late final CategoryRepository _categoryRepository = ref.watch(categoryRepositoryProvider);

  @override
  FutureOr<List<Category>> build() async {
    final categories = await _categoryRepository.getCategories();
    return categories;
  }

  void expanded(int id){
    final index = state.requireValue.indexWhere((c) => c.id == id);
    if (index == -1) {
      return;
    }
    final current = state.requireValue[index];
    var newList = List<Category>.from(state.requireValue);
    newList[index] = current.copyWith(expanded: !current.expanded);
    state = AsyncData(newList);
  }
}