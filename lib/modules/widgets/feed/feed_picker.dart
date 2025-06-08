

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/modules/controller/add_artiad/add_artiad_controller.dart';
import 'package:follow_read/modules/controller/feeds/feeds_controller.dart';
import 'package:follow_read/modules/widgets/acx/cupx_sheet_title.dart';
import 'package:follow_read/modules/widgets/acx/drag_handle.dart';
import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';
import 'package:follow_read/modules/widgets/acx/tickbox_list_tile.dart';
import 'package:follow_read/modules/widgets/feed/feed_state_tag.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';
import 'package:follow_read/theme/text_styles.dart';
import 'package:get/get.dart';


class FeedPicker extends StatefulWidget {

  const FeedPicker({super.key,});


  @override
  State<FeedPicker> createState() => _FeedPickerState();
}

class _FeedPickerState extends State<FeedPicker> {

  final controller = Get.find<FeedsController>();
  final addArtiad = Get.find<AddArtiadController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = Obx((){
      return ListView.separated(
        shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final feed = controller.state.feeds[index];
          return TickboxListTile(title: Row(children: [
              FeedIcon(title: feed.title, iconUrl: feed.iconUrl, size: 24,),
              const SizedBox(width: 12,),
              Expanded(child: Text(feed.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)),
              const SizedBox(width: 8,),
              if (feed.errorCount > 0) FeedStateTag(),
            ],),
            value: feed.id.toString(),
            tristate: addArtiad.state.feedIds.contains(feed.id),
            onChanged: (v) {
              final feedId = int.parse(v);
              addArtiad.change(feedId: feedId);
            },
          );
        },
        separatorBuilder: (_, index) => Padding(
          padding: EdgeInsets.only(left: 16 + 28 + 12 , right: 16),
          child: const SpacerDivider(indent: 0, spacing: 1, thickness: 0.5,),
        ),
        itemCount: controller.state.feeds.length,
      );
    });
    return Column(children: [
      const SheetGrabber(),
      Obx((){
        return ActionSheetTitle(
          title: '选择文件夹', enabled: addArtiad.state.feedIds.isNotEmpty,
          onPressed: () async {
            Navigator.pop(context);
        },);
      }),
      listView,
    ],);
  }

}

