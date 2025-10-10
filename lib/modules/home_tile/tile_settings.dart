

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/constant.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/cupx_list_tile_chevron.dart';
import 'package:follow_read/global/widgets/cupx_sliding_segmented_control.dart';
import 'package:follow_read/global/widgets/drag_handle.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:follow_read/modules/home_tile/tile_card.dart';
import 'package:get/get.dart';

class TileSettings extends StatelessWidget {

  final controller = Get.find<EntriesController>();
  TileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    Meta meta = controller.state.meta;
    Widget view = Column(children: [
      const DragHandle(),
      const SizedBox(height: 8,),
      if (meta is Feed) ...[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: TileCard(meta: meta),
        ),
      ],

      const SizedBox(height: 12,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: PgText("Sort by", style: AppTextStyles.M15B50, textAlign: TextAlign.start,),
      ),
      const SizedBox(height: 6,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16),
        child: Obx((){
          return CupxSlidingSegmentedControl(
            height: 48,
            segmentedHeight: 40,
            borderRadius: BorderRadius.circular(14),
            segmentedBorderRadius: BorderRadius.circular(10),
            groupValue: switch(controller.state.meta.order) {
              Model.orderPublishedAt => 'Publish Date',
              Model.orderCreatedAt => 'Add Date',
              _ => 'Publish Date',
            },
            onValueChanged: (value) {
              controller.changeMate(order: switch(value) {
                'Publish Date' => Model.orderPublishedAt,
                'Add Date' => Model.orderCreatedAt,
                _ => Model.orderPublishedAt,
              });
            },
            children: ['Publish Date', 'Add Date'],
          );
        }),
      ),
      const SizedBox(height: 16,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CardView(
          padding: EdgeInsets.symmetric(vertical: 0),//设计图是4
          borderRadius: 16,
          child: Column(children: [
            Obx(() {
              return ListTilexSwitch(
                title: "Unread only",
                value: controller.state.meta.onlyShowUnread,
                icon: SvgIcons.eyes,
                onChanged: (v) async {
                  await controller.changeMate(unreadOnly: v);
                },
              );
            }),
            // Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12,), child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),),
            // Obx(() {
            //   return ListTilexSwitch(title: "全局隐藏", value: controller.state.meta.hideGlobally, icon: SvgIcons.ban, );
            // }),
        ],)),
      ),


      Visibility(
          visible: meta is Feed,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 6),
            child: CardView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                borderRadius: 16,
                child: Column(children: [
                  ListTilexText(title: meta.siteUrl, onTap: () => copyToClipboard(meta.siteUrl)),
                  if (meta.siteUrl != meta.url) ...[
                    SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),
                    ListTilexText(title: meta.url, onTap: () => copyToClipboard(meta.url)),
                  ]
                ],)
            ),
          )),
        const SizedBox(height: 21,),
    ],);

    return view;
  }



  /// 将指定的文本内容复制到设备的剪贴板
  void copyToClipboard(String textToCopy) async {
    if (textToCopy.isEmpty) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: textToCopy));
    Get.snackbar('成功', '内容已复制');
  }
}

