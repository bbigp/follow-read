



import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/services/memory_cache_controller.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/global/widgets/drag_handle.dart';
import 'package:follow_read/global/widgets/tickbox_list_tile.dart';
import 'package:follow_read/modules/widgets/feed/feed_state_tag.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';
import 'package:get/get.dart';

import 'feed_picker_controller.dart';


class FeedPicker extends StatelessWidget {

  final List<BigInt> initialFeeds;
  final void Function(List<BigInt>)? onPressed;
  FeedPicker({super.key, this.initialFeeds = const [], this.onPressed});

  final controller = Get.find<MemoryCacheController>();
  final feedPicker = Get.find<FeedPickerController>();

  @override
  Widget build(BuildContext context) {
    Widget listView = Obx((){
      return ListView.separated(
        shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final feed = controller.feeds[index];
          return TickboxListTile(
            title: Row(children: [
              FeedIcon(title: feed.title, iconUrl: feed.iconUrl),
              const SizedBox(width: 12,),
              Expanded(child: Text(feed.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)),
              const SizedBox(width: 8,),
              if (feed.errorCount > 0) FeedStateTag(),
            ],),
            value: feed.id.toString(),
            tristate: feedPicker.feeds.contains(feed.id),
            onChanged: (v) => feedPicker.change(v),
          );
        },
        separatorBuilder: (_, index) => Padding(
          padding: EdgeInsets.only(left: 16 + 28 + 12 , right: 16),
          child: const SpacerDivider(indent: 0, spacing: 1, thickness: 0.5,),
        ),
        itemCount: controller.feedLen,
      );
    });
    return Column(children: [
      const SheetGrabber(),
      Obx((){
        return ActionSheetTitle(
          title: '选择文件夹',
          enabled: feedPicker.feeds.isNotEmpty,
          onPressed: () async {
            onPressed?.call(feedPicker.feeds.toList());
            Get.back();
          },);
      }),
      listView,
    ],);
  }

}

