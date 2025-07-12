import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/global/widgets/context_menu.dart';
import 'package:follow_read/global/widgets/modal_wrapper.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/modules/add_feed/add_feed_controller.dart';
import 'package:follow_read/modules/add_feed/add_feed_form.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import 'main_tile.dart';

///
class FeedTile extends StatelessWidget {
  final Feed feed;

  const FeedTile({
    super.key,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainTile(
          id: "e${feed.id}",
          leadingIndicator: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(SvgIcons.dot_s, width: 24, height: 24, fit: BoxFit.contain, //设计图dot_s半径1.5
              colorFilter: ColorFilter.mode(
                AppColors.black50,
                BlendMode.srcIn,
              ), //设计图black8
            ),
          ),
          icon: FeedIcon(title: feed.title, iconUrl: feed.iconUrl, size: 24,),
          contextMenus: feed.contextMenus(context),
          title: feed.title,
          onTap: () => Get.toNamed(RouteConfig.entry),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12 + 24 + 4, right: 16),
          child: SpacerDivider(thickness: 0.5, spacing: 0.5, indent: 0,),
        ),
      ],
    );
  }
}
