

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/constant.dart';
import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/cupx_list_tile_chevron.dart';
import 'package:follow_read/global/widgets/cupx_sliding_segmented_control.dart';
import 'package:follow_read/global/widgets/drag_handle.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
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
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
        child: TileCard(meta: meta),
      ),

      const SizedBox(height: 12,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: PgText("排序", style: AppTextStyles.M15B50),
      ),
      const SizedBox(height: 6,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16),
        child: CupxSlidingSegmentedControl(
          height: 48,
          segmentedHeight: 40,
          borderRadius: BorderRadius.circular(14),
          segmentedBorderRadius: BorderRadius.circular(10),
          groupValue: switch(meta.order) {
            Model.orderPublishedAt => '发布时间',
            Model.orderCreatedAt => '添加时间',
            _ => '发布时间',
          },
          onValueChanged: (value) {
            controller.changeMate(order: switch(value) {
              '发布时间' => Model.orderPublishedAt,
              '添加时间' => Model.orderCreatedAt,
              _ => Model.orderPublishedAt,
            });
          },
          children: ['发布时间', '添加时间'],
        ),
      ),
      const SizedBox(height: 16,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CardView(
          padding: EdgeInsets.symmetric(vertical: 4),
          borderRadius: 16,
          child: Column(children: [
            ListTilexSwitch(title: "只显示未读", value: true, icon: SvgIcons.eyes, ),
            ListTilexSwitch(title: "全局隐藏", value: true, icon: SvgIcons.ban, ),
        ],)),
      ),

      Visibility(
          visible: meta is Feed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Website', style: AppTextStyles.caption500,),
          )
      ),
      Visibility(
        visible: meta is Feed,
        child: CardView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(meta.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)
        ),
      ),
      const SizedBox(height: 21,),
    ],);

    return view;
  }

}

