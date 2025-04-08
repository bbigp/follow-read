

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/data/repositories/category_repository.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';

import '../../domain/models/listx.dart';
import '../../domain/models/tile.dart';



final tileProvider = AsyncNotifierProvider.family.autoDispose<TileNotifier, Tile, String>(
    TileNotifier.new
);


class TileNotifier extends AutoDisposeFamilyAsyncNotifier<Tile, String> {

  late final CategoryRepository _categoryRepository = ref.watch(categoryRepository);
  late final FeedRepository _feedRepository = ref.watch(feedRepositoryProvider);
  late final TileType type;
  late final int id;

  @override
  FutureOr<Tile> build(arg) async {
    return load(arg);
  }

  Future<Tile> load(String pid) async {
    final pageId = PageUtils.parsePid(pid);
    type = pageId.type;
    id = pageId.id;
    try {
      if (type == TileType.feed) {
        final feed = await _feedRepository.getFeedById(id);
        return Tile(type: type, feed: feed);
      }
      if (type == TileType.folder) {
        final category = await _categoryRepository.getCategoryById(id);
        final feeds = await _feedRepository.getFeedsByCategoryId(id);
        return Tile(type: type, feeds: feeds, category: category);
      }
      if (type == TileType.list) {
        final listx = Listx.pageAll.firstWhere((item) => item.id == id);
        return Tile(type: type, listx: listx);
      }
      return Future.error("error type");
    } catch (e, stackTrace) {
      return Future.error(e, stackTrace);
    }
  }

  Future<void> saveShow({bool? onlyShowUnread, bool? showReadingTime, String? orderx}) async{
    if (type == TileType.feed) {
      final success = await _feedRepository.updateShow(id,
        onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime,
        orderx: orderx,
      );
      if (success) {
        final newFeed = state.value!.feed.copyWith(
            onlyShowUnread: onlyShowUnread,
            showReadingTime: showReadingTime,
          orderx: orderx,
        );
        state = AsyncData(state.value!.copyWith(feed: newFeed));
      }
    }
    if (type == TileType.folder) {
      final success = await _categoryRepository.updateShow(id,
        onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime,
        orderx: orderx,
      );
      if (success) {
        final newValue = state.value!.category.copyWith(
            onlyShowUnread: onlyShowUnread,
            showReadingTime: showReadingTime,
          orderx: orderx,
        );
        state = AsyncData(state.value!.copyWith(category: newValue));
      }
    }
  }

}

