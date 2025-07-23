

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/cupx_list_tile_chevron.dart';
import 'package:follow_read/global/widgets/cupx_sliding_segmented_control.dart';
import 'package:follow_read/global/widgets/drag_handle.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

class TileSettings extends StatelessWidget {

  TileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    Widget view = Column(children: [
      const DragHandle(),
      const SizedBox(height: 8,),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
        child: CardView(
            borderRadius: 16,
            color: Colors.transparent,
            border: Border.all(color: AppColors.black08, width: 1),
            padding: EdgeInsets.all(6),
            child: Row(children: [
              const SizedBox(width: 6,),
              const SizedBox(width: 36, height: 36,),
              
              const SizedBox(width: 12,),
              Expanded(child: PgText("", style: AppTextStyles.M15),),
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
              )
            ],)),
      ),

      const SizedBox(height: 12,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: PgText("text", style: AppTextStyles.M15B50),
      ),
      const SizedBox(height: 6,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16),
        child: CupxSlidingSegmentedControl(
          height: 48,
          segmentedHeight: 40,
          borderRadius: BorderRadius.circular(14),
          segmentedBorderRadius: BorderRadius.circular(10),
          groupValue: "发布时间",
          onValueChanged: (value) {
            // setState(() {
            //   _selectedSegment = value!;
            // });
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
            ListTilexSwitch(title: "自动已读", value: true, icon: SvgIcons.book, )
        ],)),
      ),
      const SizedBox(height: 21,),
    ],);

    return view;


    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     Container(
    //       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    //       padding: EdgeInsets.all(6),
    //       height: 60,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(16),
    //         border: Border.all(width: 1, color: AppTheme.black8),
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: 6,
    //           ),
    //           FeedIcon(
    //             title: tile.title,
    //             iconUrl: tile.iconUrl,
    //             size: 36,
    //           ),
    //           SizedBox(
    //             width: 12,
    //           ),
    //           Expanded(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     tile.title,
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: TextStyle(
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.w500,
    //                       height: 1.33,
    //                       color: AppTheme.black95,
    //                     ),
    //                   ),
    //                   if (tile.type == TileType.feed)
    //                     Text(
    //                       tile.feedUrl,
    //                       maxLines: 1,
    //                       overflow: TextOverflow.ellipsis,
    //                       style: TextStyle(
    //                         fontSize: 13,
    //                         fontWeight: FontWeight.w400,
    //                         height: 1.38,
    //                         color: AppTheme.black50,
    //                       ),
    //                     ),
    //                 ],
    //               )),
    //           SizedBox(
    //             width: 8,
    //           ),
    //           InkWell(
    //             onTap: () {
    //               if (tile.type == TileType.cluster) {
    //                 // ref
    //                 // .watch(routerProvider)
    //                 // .pushNamed(RouteNames.cluster, queryParameters: {
    //                 // "id": tile.id.toString(),
    //                 // });
    //               }
    //               if (tile.type == TileType.feed) {
    //                 Navigator.of(context).pop();
    //                 OpenModal.open(context, FeedForm(id: tile.id, shouldPop: true,));
    //               }
    //             },
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(12),
    //                 color: AppTheme.black8,
    //               ),
    //               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    //               child: SvgPicture.asset(
    //                 Svgicons.edit,
    //                 height: 20,
    //                 width: 20,
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //     const SizedBox(height: 16,),
    //     const Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 20),
    //       child: Text('排序', style: AppTextStyles.caption500,),
    //     ),
    //     const SizedBox(height: 6,),
    //     Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 16),
    //       child: CupxSlidingSegmentedControl.big(
    //         groupValue: switch(tile.orderx) {
    //           Model.orderxPublishedAt => '发布时间',
    //           Model.orderxCreatedAt => '添加时间',
    //           _ => '发布时间',
    //         },
    //         onValueChanged: (value) {
    //           var v = switch(value) {
    //             '发布时间' => Model.orderxPublishedAt,
    //             '添加时间' => Model.orderxCreatedAt,
    //             _ => Model.orderxPublishedAt,
    //           };
    //           ref.read(tileProvider(pid).notifier).saveShow(orderx: v);
    //         },
    //         children: ['发布时间', '添加时间'],
    //       ),
    //     ),
    //     const SizedBox(height: 16,),
    //     const SizedBox(height: 8,),
    //     FeedSwitch(
    //       id: id,
    //       type: type,
    //     ),
    //     const SizedBox(height: 16,),
    //     const SizedBox(height: 8,),
    //     Visibility(
    //         visible: tile.type == TileType.feed,
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 20),
    //           child: Text('Website', style: AppTextStyles.caption500,),
    //         )
    //     ),
    //     Visibility(
    //       visible: tile.type == TileType.feed,
    //       child: CardView(
    //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    //           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    //           child: Text(tile.feed.siteUrl, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)
    //       ),
    //     ),
    //     const SizedBox(height: 21,)
    //   ],
    // );
  }

}

