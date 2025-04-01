import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../../routes/app_route.dart';
import '../../domain/models/feed.dart';
import 'feed_icon.dart';

class FeedItem extends ConsumerWidget {
  final Feed feed;

  const FeedItem({super.key, required this.feed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ref.read(routerProvider).pushNamed(
                RouteNames.entry,
                pathParameters: {'feedId': feed.id.toString()},
                queryParameters: {
                    'onlyShowUnread': feed.onlyShowUnread.toString(),
                }
            );
          },
          child: Container(
            height: 52,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FeedIcon(
                  title: feed.title,
                  iconUrl: feed.iconUrl,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        feed.title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.black95,
                        ),
                      )),
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
                          padding: EdgeInsets.only(left: 2, right: 14, top: 4, bottom: 4,),
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
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    '${feed.unread > 0 ? feed.unread : ''}',
                    style: const TextStyle(
                      color: AppTheme.black25,
                      fontSize: 13,
                      height: 1.38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SpacerDivider(
          spacing: 1,
          thickness: 0.5,
        ),
      ],
    );
  }
}
