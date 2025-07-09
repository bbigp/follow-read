import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/global/widgets/context_menu.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import 'main_tile.dart';

///
class FeedTile extends ConsumerWidget {
  final Feed feed;

  const FeedTile({
    super.key,
    required this.feed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ContextMenuEntry> contextMenus = [
      ContextMenu(
          label: '编辑',
          icon: SvgIcons.edit,
          onTap: () {
            // Open.modal(context, FeedForm(id: feed.id,));
          }),
      const ContextMenuDivider(),
      ContextMenu(
          label: "取消订阅",
          icon: SvgIcons.reduce_o,
          type: ContextMenuType.danger,
          onTap: () {
            // OpenModal.open(context, AlertSheet(
            //   title: "确认取消订阅?",
            //   msg: "该订阅将从所有文件夹和列表中删除",
            //   onPressed: () async {
            //     var success = await ref.read(feedRepositoryProvider).removeFeed(feed.id);
            //     if (success) {
            //       // final _ = ref.refresh(homeProvider);
            //       Navigator.of(context).pop();
            //     }
            //   },
            // ), hasMargin: true);
          }),
    ];
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
          contextMenus: contextMenus,
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
