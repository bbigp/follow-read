

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';
import 'package:follow_read/features/presentation/widgets/feed/empty_feed_view.dart';
import 'package:follow_read/features/presentation/widgets/home/feed_tile.dart';
import 'package:follow_read/features/presentation/widgets/home/folder_tile.dart';

///
class FeedStream extends ConsumerWidget {

  const FeedStream({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamList = ref.watch(homePageProvider.select((s) => s.requireValue.tiles));
    if (streamList.isEmpty) {
      return SliverToBoxAdapter(child: EmptyFeedView(),);
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = streamList[index];
          return switch(item.type) {
            TileType.feed => FeedTile(feed: item.feed),
            TileType.folder => FolderTile(folder: item.category),
            _ => const SizedBox.shrink(),
          };
        },
        childCount: streamList.length,
      ),
    );
  }


}