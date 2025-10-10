import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/constant.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/element_type.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';

///
class EntryTileHeader extends StatelessWidget {
  final String title;
  final String iconUrl;
  final DateTime time;

  const EntryTileHeader({
    super.key,
    required this.title,
    required this.iconUrl,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FeedIcon(title: title, iconUrl: iconUrl, size: ElementSize.small,),
        const SizedBox(width: 6,),
        Expanded(child: PgText(
          title,
          maxLines: 1,
          style: AppTextStyles.text13500,
        ),),
        const SizedBox(width: 6,),
        PgText(
          time.toShowTime(),
          maxLines: 1,
          maxWidth: 80,
          textAlign: TextAlign.right,
          style: AppTextStyles.M13B25,
        ),
      ],
    );
  }
}

class EntryTileHeaderSkeleton extends StatelessWidget {
  const EntryTileHeaderSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Container(width: 18, height: 18, color: Colors.white,),
      ),
      const SizedBox(width: 6,),
      Container(width: 72, height: 12, decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.white,
      ),),
    ],);
  }
}
