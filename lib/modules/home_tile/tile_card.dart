


import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

class TileCard extends StatelessWidget {

  final Meta meta;
  const TileCard({super.key, required this.meta});

  @override
  Widget build(BuildContext context) {
    if (meta is Feed) {
      final feed  = meta as Feed;
      return CardView(
          borderRadius: 16,
          color: Colors.transparent,
          border: Border.all(color: AppColors.black08, width: 1),
          padding: EdgeInsets.all(6),
          child: Row(children: [
            const SizedBox(width: 6,),
            FeedIcon(title: feed.title, iconUrl: feed.iconUrl, sizex: Sizex.large,),

            const SizedBox(width: 12,),
            Expanded(child: PgText(feed.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.M15),),
            const SizedBox(width: 6,),

            const SizedBox(width: 8,),
            IconButtonx(
              icon: SvgIcons.edit,
              type: ButtonxType.secondary,
              size: Sizex.custom,
              buttonSize: mediumCompact().copyWith(
                height: 48, padding: 20,
                borderRadius: BorderRadius.circular(12),
              ),
              enabled: true,
              onPressed: () async {
                Get.back();
                Get.toNamed(RouteConfig.addFeed, parameters: {"id": feed.id.toString()});
              },
            )
          ],));
    }
    return const SizedBox.shrink();
  }
}