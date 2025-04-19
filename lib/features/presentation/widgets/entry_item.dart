import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/presentation/widgets/feed_icon.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../domain/models/entry.dart';
import '../../domain/models/tile.dart';
import 'lazy_image.dart';

class EntryItem extends ConsumerWidget {
  final Entry entry;
  final Tile tile;

  const EntryItem({
    super.key,
    required this.entry,
    required this.tile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildContent(ref);
  }

  Widget _buildContent(WidgetRef ref) {
    return GestureDetector(
      onTap: (){
        ref.read(routerProvider).pushNamed(RouteNames.entryDetail, pathParameters: {
          'entryId': entry.id.toString(),
        });
      },
      child: Column(
        children: [
          const SizedBox(height: 16,),
          Row(
            children: [
              FeedIcon(
                key: ValueKey(entry.feed.iconUrl + entry.feed.title),
                title: entry.feed.title,
                iconUrl: entry.feed.iconUrl,
                size: 18,
                radius: 4,
                textStyle: TextStyle(
                  fontSize: 11,
                  height: 1.33,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6,),
              Expanded(
                child: Text(
                  entry.feed.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.38,
                    color: AppTheme.black95,
                  ),
                ),
              ),
              Text(
                tile.orderx == Frc.orderxCreatedAt
                    ? entry.createdAt.toShowTime()
                    : entry.publishedAt.toShowTime(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.38,
                  color: AppTheme.black25,
                ),
              )
            ],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      entry.title,
                      maxLines:
                      entry.getTilteLines(tile.showReadingTime),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.33,
                        color: AppTheme.black95,
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Visibility(
                        visible: tile.showReadingTime,
                        child: Row(
                          children: [
                            const Svgicon(
                              Svgicons.readingTime,
                              size: 14,
                              iconSize: 14,
                            ),
                            const SizedBox(width: 4,),
                            Expanded(child: Text(
                              '${entry.readingTime}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                height: 1.38,
                                color: AppTheme.black50,
                              ),
                            ),),
                          ],
                        )
                    ),
                    const SizedBox(height: 4,),
                    Visibility(
                      visible: entry.description != "",
                      child: Text(
                        entry.description,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          height: 1.38,
                          color: AppTheme.black50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12,),
              Visibility(visible: entry.pic != "", child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: GestureDetector(
                  onTap: () {
                    ref.watch(routerProvider).pushNamed(RouteNames.imageGallery, extra: {
                      "imageUrls": entry.allImageUrls,
                      "index": 0,
                    });
                  },
                  child: LazyImage(url: entry.pic,),
                ),
              )),
            ],
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}

