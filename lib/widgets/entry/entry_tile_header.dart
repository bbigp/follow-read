import 'package:flutter/material.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/widgets/feed_icon.dart';
import 'package:follow_read/theme/text_styles.dart';

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
        FeedIcon(title: title, iconUrl: iconUrl, size: 18, radius: 4,),
        const SizedBox(width: 6,),
        Expanded(child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.text13500,
        )),
        const SizedBox(width: 6,),
        Text(
          time.toShowTime(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.hint13500,
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
