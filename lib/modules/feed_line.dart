


import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/element_type.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';

class FeedLine extends StatelessWidget {
  final Feed feed;
  final GestureTapCallback? onTap;
  const FeedLine({super.key, required this.feed, this.onTap});
  @override
  Widget build(BuildContext context) {
    Widget view = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(children: [
        FeedIcon(title: feed.title, iconUrl: feed.iconUrl, size: ElementSize.large,),
        const SizedBox(width: 16, height: 40,),
        Expanded(child: Column(children: [
          PgText(feed.title, style: AppTextStyles.M15, maxLines: 1),
          const SizedBox(height: 2,),
          PgText(feed.feedUrl, style: AppTextStyles.R13B50, maxLines: 1),
        ],)),
        // if (1==2) ...[
        //   const SizedBox(width: 16,),
        //   IconButtonx(icon: SvgIcons.add, size: Sizex.custom,
        //     type: ElementType.primary,
        //     buttonSize: smallCompact(),
        //   ),
        // ]
      ],),
    );
    return onTap == null ? view : InkWell(onTap: onTap, child: view,);
  }

}