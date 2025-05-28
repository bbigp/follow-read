

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/widgets/components/dashed_line.dart';
import 'package:follow_read/theme/text_styles.dart';

///
class FeedSummary extends ConsumerWidget {

  final Tile feed;
  const FeedSummary({super.key, required this.feed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 8,),
        Text(feed.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text28500,),

        if (feed.unread > 0 ) ...[
          const SizedBox(height: 4,),

          const SizedBox(height: 2,),
          Row(children: [
            const SizedBox(width: 4,),
            Text('${feed.unread}未读', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.hint11500,),
            const SizedBox(width: 4,),
          ],),
        ],

        const SizedBox(height: 16,),
        const DashedDivider(indent: 0, spacing: 16, thickness: 1, color: AppTheme.black8,),
    ],),);
  }

}

class FeedSummarySkeleton extends StatelessWidget {
  const FeedSummarySkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 8,),
        Text('All', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text28500,),

        const SizedBox(height: 4,),
        Container(width: 15, height: 69, color: Colors.white,),

        const SizedBox(height: 16,),
        const DashedDivider(indent: 0, spacing: 16, thickness: 1, color: Colors.white,),
      ],),
    );
  }
}