

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/folder.dart';
import 'app_container.dart';

part 'folder_provider.g.dart';

@riverpod
class AllFolders extends _$AllFolders {
  @override
  Future<List<Category>> build() async {
    final repo = ref.watch(categoryRepositoryProvider);
    return await repo.getCategories(showAll: false);
  }
}