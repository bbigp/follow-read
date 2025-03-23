
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';

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
        SizedBox(
          height: 52,
          child: ListTile(
            dense: true,
            horizontalTitleGap: 12, // 图标与标题的水平间距
            onTap: () {
              ref.read(routerProvider).pushNamed(
                  RouteNames.entry,
                  pathParameters: {'feedId': feed.id.toString()}
              );
            },
            leading: FeedIcon(
              title: feed.title,
              iconUrl: feed.iconUrl,
            ),
            title: Text(feed.title,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                  color: AppTheme.black95,
                )),
            trailing: Text(
              '${feed.unread > 0 ? feed.unread : ''}',
              style: const TextStyle(
                color: AppTheme.black25,
                fontSize: 13,
                height: 1.38,
                fontWeight: FontWeight.w500,
              ),
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