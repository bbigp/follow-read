import 'package:flutter/cupertino.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/presentation/widgets/feed_icon.dart';
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
