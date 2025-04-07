

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/data/repositories/category_repository.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';

import '../../domain/models/feed.dart';
import '../../domain/models/tile.dart';

final tileProvider = StateNotifierProvider.autoDispose.family<
    TileNotifier, AsyncValue<Tile>, String>((ref, pid) {
  return TileNotifier(pid: pid, ref: ref,);
});

class TileNotifier extends StateNotifier<AsyncValue<Tile>> {

  final int id;
  final TileType type;
  final CategoryRepository _categoryRepository;
  final FeedRepository _feedRepository;
  final Ref ref;

  TileNotifier({
    required String pid,
    required this.ref,
  })
      : id = PageUtils.parsePid(pid).id,
        type = PageUtils.parsePid(pid).type,
        _categoryRepository = ref.read(categoryRepository),
        _feedRepository = ref.read(feedRepositoryProvider),
      super(AsyncValue.loading());

  Future<void> loadData() async {
    try {
      if (type == TileType.feed) {
        final feed = await _feedRepository.getFeedById(id);
        state = AsyncData(Tile(type: type, feed: feed));
        return;
      }
      if (type == TileType.folder) {
        final category = await _categoryRepository.getCategoryById(id);
        final feeds = await _feedRepository.getFeedsByCategoryId(id);
        state = AsyncData(Tile(type: type, feeds: feeds, category: category));
        return;
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> saveShow({bool? onlyShowUnread, bool? showReadingTime}) async{
    if (type == TileType.feed) {
      final success = await _feedRepository.updateShow(id,
        onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime,
      );
      if (success) {
        final newFeed = state.value!.feed.copyWith(onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime);
        state = AsyncData(state.value!.copyWith(feed: newFeed));
      }
    }
    if (type == TileType.folder) {
      final success = await _categoryRepository.updateShow(id,
        onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime,
      );
      if (success) {
        final newValue = state.value!.category.copyWith(onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime);
        state = AsyncData(state.value!.copyWith(category: newValue));
      }
    }
  }

}

