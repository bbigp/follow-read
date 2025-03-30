import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/widgets/feed_icon.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../domain/models/entry.dart';
import '../../domain/models/feed.dart';

class EntryItem extends ConsumerWidget {
  final Entry entry;
  final Feed feed;

  const EntryItem({
    super.key,
    required this.entry,
    required this.feed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildContent(ref);
  }

  Widget _buildContent(WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () {
              ref.read(routerProvider).pushNamed(RouteNames.entryDetail, pathParameters: {
                'entryId': entry.id.toString(),
              });
            },
            child: Column(
              children: [
                SizedBox(
                  height: 18,
                  child: Row(
                    children: [
                      FeedIcon(
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
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 6),
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
                      ),
                      SizedBox(
                        child: Text(
                          entry.publishedAt.toShowTime(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.38,
                            color: AppTheme.black25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 4,
                              ),
                              child: Text(
                                entry.title,
                                maxLines:
                                    entry.getTilteLines(feed.showReadingTime),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1.33,
                                  color: AppTheme.black95,
                                ),
                              ),
                            ),
                            if (feed.showReadingTime)
                              Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: SizedBox(
                                  height: 18,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Svgicon(
                                          Svgicons.readingTime,
                                          size: 14,
                                          iconSize: 14,
                                        ),
                                      ),
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
                                  ),
                                ),
                              ),
                            if (entry.description != "")
                              Text(
                                entry.description,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  height: 1.38,
                                  color: AppTheme.black50,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (entry.pic != "")
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .watch(routerProvider)
                                    .pushNamed(RouteNames.imageGallery, extra: {
                                  "imageUrls": [entry.pic],
                                  "index": 0,
                                });
                              },
                              child: CachedNetworkImage(
                                imageUrl: entry.pic,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300], // 错误时的背景颜色
                                  child: Icon(Icons.error,
                                      color: Colors.red), // 错误图标
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SpacerDivider(
          indent: 16,
          spacing: 1,
          thickness: 0.5,
        ),
      ],
    );
  }
}

class SkeletonEntryItem extends StatelessWidget {
  const SkeletonEntryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Container(
                      width: 18,
                      height: 18,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6, top: 3, bottom: 3),
                    child: Container(
                      width: 72,
                      height: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 0,
                            ),
                            child: Container(
                              width: 154,
                              height: 14,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              width: 254,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 6,
                            ),
                            child: Container(
                              width: 134,
                              height: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 36),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SpacerDivider(
          indent: 16,
          spacing: 1,
          thickness: 0.5,
          color: Colors.white,
        ),
      ],
    );
  }
}
