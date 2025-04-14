

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/data/repositories/category_repository.dart';
import 'package:follow_read/features/data/repositories/cluster_repository.dart';
import 'package:follow_read/features/data/repositories/feed_repository.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/user_provider.dart';

import '../../../core/utils/logger.dart';
import '../../domain/models/feed.dart';
import '../../domain/models/tile.dart';



final tileProvider = AsyncNotifierProvider.family.autoDispose<TileNotifier, Tile, String>(
    TileNotifier.new
);


class TileNotifier extends AutoDisposeFamilyAsyncNotifier<Tile, String> {

  late final CategoryRepository _categoryRepository = ref.watch(categoryRepository);
  late final FeedRepository _feedRepository = ref.watch(feedRepositoryProvider);
  late final ClusterRepository _clusterRepository = ref.watch(clusterRepository);
  late final TileType type;
  late final int id;

  @override
  FutureOr<Tile> build(arg) async {
    logger.i('初始化tile notifier');
    return load(arg);
  }

  Future<Tile> load(String pid) async {
    bool showAll = await ref.watch(showAllProvider);
    final pageId = PageUtils.parsePid(pid);
    type = pageId.type;
    id = pageId.id;
    try {
      if (type == TileType.feed) {
        final feed = await _feedRepository.getFeedById(id);
        if (!showAll && feed.hideGlobally) {
          return Tile(type: type);
        }
        return Tile(type: type, feed: feed);
      }
      if (type == TileType.folder) {
        final category = await _categoryRepository.getCategoryById(id);
        if (!showAll && category.hideGlobally) {
          return Tile(type: type);
        }
        var feeds = await _feedRepository.getFeedsByCategoryId(id);
        feeds = feeds.where((item) {
          if (showAll) return true;
          return !item.hideGlobally;
        }).toList();
        return Tile(type: type, feeds: feeds, category: category);
      }
      if (type == TileType.cluster) {
        final cluster = await _clusterRepository.getById(id);
        if (!showAll && cluster.hideGlobally) {
          return Tile(type: type);
        }
        final feeds = await _feedRepository.getFeeds(ids: cluster.feedIds);
        if (showAll) {
          return Tile(type: type, cluster: cluster, feeds: feeds);
        }

        final Map<int, List<Feed>> feedsMap = feeds
            .where((item) => !item.hideGlobally) //过滤掉 hide的feed
            .toList()
            .fold<Map<int, List<Feed>>>(
          {},
          (map, feed) {
            final cid = feed.categoryId;
            map.putIfAbsent(cid, () => []);
            map[cid]!.add(feed);
            return map;
          },
        );
        //判断分类是否是hide的
        final categories = await _categoryRepository.getCategories();
        List<Feed> needs = [];
        for (final category in categories) {
          if (!category.hideGlobally) {
            needs.addAll(feedsMap[category.id] ?? []);
          }
        }
        return Tile(type: type, cluster: cluster, feeds: needs);
      }
      return Future.error("error type");
    } catch (e, stackTrace) {
      return Future.error(e, stackTrace);
    }
  }

  Future<void> saveShow({bool? onlyShowUnread, bool? showReadingTime,
    String? orderx, bool? hideGlobally, }) async {
    if (type == TileType.feed) {
      final success = await _feedRepository.updateShow(id,
        onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime,
        orderx: orderx, hideGlobally: hideGlobally,
      );
      if (success) {
        final newFeed = state.value!.feed.copyWith(
            onlyShowUnread: onlyShowUnread,
            showReadingTime: showReadingTime,
          order: orderx,
          hideGlobally: hideGlobally,
        );
        state = AsyncData(state.value!.copyWith(feed: newFeed));
      }
    }
    if (type == TileType.folder) {
      final success = await _categoryRepository.updateShow(id,
        onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime,
        orderx: orderx,
        hideGlobally: hideGlobally,
      );
      if (success) {
        final newValue = state.value!.category.copyWith(
          onlyShowUnread: onlyShowUnread,
          showReadingTime: showReadingTime,
          order: orderx,
          hideGlobally: hideGlobally,
        );
        state = AsyncData(state.value!.copyWith(category: newValue));
      }
    }
    if (type == TileType.cluster) {
      final success = await _clusterRepository.updateShow(id,
        onlyShowUnread: onlyShowUnread, showReadingTime: showReadingTime,
        orderx: orderx,
        hideGlobally: hideGlobally,
      );
      if (success) {
        final newValue = state.value!.cluster.copyWith(
          onlyShowUnread: onlyShowUnread,
          showReadingTime: showReadingTime,
          order: orderx,
          hideGlobally: hideGlobally,
        );
        state = AsyncData(state.value!.copyWith(cluster: newValue));
      }
    }
  }

}

