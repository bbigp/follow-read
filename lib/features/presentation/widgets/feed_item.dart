import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';
import 'package:follow_read/features/presentation/providers/unread_count_notifier.dart';
import 'package:follow_read/features/presentation/widgets/context_menu_wrapper.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/theme/text_styles.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../../routes/app_route.dart';
import '../../domain/models/feed.dart';
import '../../domain/models/tile.dart';
import 'components/context_menu.dart';
import 'feed/feed_creator.dart';
import 'feed_icon.dart';
import 'open_modal.dart';

class FeedItem extends ConsumerWidget {
  // final Feed feed;
  final Tile tile;

  const FeedItem({super.key, required this.tile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (tile.type == TileType.feed)
          _FeedItem(feed: tile.feed)
        else if (tile.type == TileType.folder)
          _FolderItem(tile: tile)
      ],
    );
  }
}

class _FolderItem extends ConsumerWidget {
  final Tile tile;

  const _FolderItem({required this.tile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      InkWell(
        onTap: () {
          ref.read(routerProvider).pushNamed(RouteNames.entry, pathParameters: {
            'id': tile.id.toString(),
            'type': tile.type.toString(),
          });
        },
        child: Row(
          children: [
            const SizedBox(width: 12,),
            GestureDetector(
              onTap: () {
                ref.read(homePageProvider.notifier).expanded(tile.id);
              },
              child: Svgicon(
                tile.expanded ? Svgicons.triangleDown : Svgicons.triangleRight,
                size: 24,
                iconSize: 20,
              ),
            ),
            SizedBox(
              width: 4, height: 52,
            ),
            SizedBox(
              width: 4, height: 52,
            ),
            Svgicon(
              Svgicons.group,
              size: 24,
              iconSize: 20,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                tile.title,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.black95,
                ),
              ),
            ),
            if (tile.errorCount > 0)
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: AppTheme.red10,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Svgicons.expired,
                      width: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 2,
                        right: 14,
                        top: 4,
                        bottom: 4,
                      ),
                      child: Text(
                        '错误',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.18,
                          color: AppTheme.red,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            SizedBox(
              width: 12,
            ),
            Text(
              '${tile.unread > 0 ? tile.unread : ''}',
              style: const TextStyle(
                color: AppTheme.black25,
                fontSize: 13,
                height: 1.38,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            const SizedBox(width: 12,),
          ],
        ),
      ),
      Padding(padding: EdgeInsets.only(left: 24 + 4 + 12, right: 12), child: SpacerDivider(
        spacing: 1,
        thickness: 0.5, indent: 0,
      ),),
      if (tile.expanded)
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tile.feeds.length,
          separatorBuilder: (_, __) => const SizedBox.shrink(),
          itemBuilder: (context, index) => _FeedItem(feed: tile.feeds[index],
              hasDot: false,),
        ),
    ],);
  }
}

class _FeedItem extends ConsumerWidget {
  final Feed feed;
  final bool hasDot;

  const _FeedItem({required this.feed, this.hasDot = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ContextMenuWrapper(
          menuItems: [
            ContextMenuEntry(
              onTap: (){
                OpenModal.open(context, FeedCreator(id: feed.id,), scrollable: false);
              },
              child: ContextMenu(label: '编辑', icon: Svgicons.edit,)
            ),
            ContextMenuEntry.divider(),
            ContextMenuEntry(
                onTap: (){

                },
                child: ContextMenu(label: '取消订阅', icon: Svgicons.reduceO, textStyle: AppTextStyles.red,)
            )
          ],
          child: FeedTile(feed: feed, hasDot: hasDot,),
        ),
        Padding(padding: EdgeInsets.only(left: 12 + 24 + 4, right: 12), child: SpacerDivider(
          spacing: 1,
          thickness: 0.5, indent: 0,
        ),)
      ],
    );
  }
}

class FeedTile extends ConsumerWidget {

  final Feed feed;
  final bool hasDot;
  const FeedTile({super.key, required this.feed, this.hasDot = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(routerProvider).pushNamed(RouteNames.entry, pathParameters: {
          'id': feed.id.toString(),
          'type': TileType.feed.toString()
        });
      },
      child: Row(
        children: [
          SizedBox(width: 12,),
          hasDot ? Svgicon(
            Svgicons.dot,
            size: 24,
            iconSize: 20,
          ) : SizedBox(width: 24, height: 24,),
          SizedBox(
            width: 4, height: 52,
          ),
          SizedBox(
            width: 4, height: 52,
          ),
          FeedIcon(
            title: feed.title,
            iconUrl: feed.iconUrl,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              feed.title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppTheme.black95,
              ),
            ),
          ),
          if (feed.errorCount > 0)
            Container(
              padding: EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: AppTheme.red10,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Svgicons.expired,
                    width: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 2,
                      right: 14,
                      top: 4,
                      bottom: 4,
                    ),
                    child: Text(
                      '错误',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.18,
                        color: AppTheme.red,
                      ),
                    ),
                  )
                ],
              ),
            ),
          SizedBox(
            width: 12,
          ),
          UnreadView(feedId: feed.id),
          SizedBox(
            width: 4,
          ),
          const SizedBox(width: 12,),
        ],
      ),
    );
  }

}

class UnreadView extends ConsumerWidget {

  final int feedId;

  const UnreadView({super.key, required this.feedId,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(feedUnreadProvider(feedId));
    return Text(count.isLoading || count.requireValue == 0 ? '' : count.requireValue.toString(), style: AppTextStyles.hint13500,);
  }

}
