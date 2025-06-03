import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/repositories/category_repository.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/feeds_provider.dart';

import 'app_container.dart';

final foldersProvider = AsyncNotifierProvider.autoDispose<FoldersNotifier, List<Category>>(
    FoldersNotifier.new
);


class FoldersNotifier extends AutoDisposeAsyncNotifier<List<Category>> {
  late final CategoryRepository _categoryRepository = ref.watch(categoryRepositoryProvider);

  @override
  FutureOr<List<Category>> build() async {
    final folders = await _categoryRepository.getCategories();
    final feeds = await ref.watch(feedsProvider.future);
    final Map<int, List<Feed>> folderFeedsMap = feeds.fold<Map<int, List<Feed>>>({}, (map, feed) {
      final cid = feed.categoryId;
      map.putIfAbsent(cid, () => []);
      map[cid]!.add(feed);
      return map;
    },);
    List<Category> f = [];
    for (final folder in folders) {
      f.add(folder.copyWith(feeds: folderFeedsMap[folder.id] ?? []));
    }
    return f;
  }

}