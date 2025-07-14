import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import 'entry_tile_body_single_image.dart';
import 'entry_tile_body_text_only.dart';
import 'entry_tile_header.dart';


///
class EntryTile extends StatelessWidget {
  final Entry entry;

  const EntryTile({super.key, required this.entry,});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildContent(),
      const SpacerDivider(indent: 16, spacing: 1, thickness: 0.5,),
    ],);
  }

  Widget _buildContent() {
    Widget child = Container(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          EntryTileHeader(title: entry.feed.title, iconUrl: entry.feed.iconUrl, time: entry.createdAt,),
          const SizedBox(height: 8,),
          entry.pic.isEmpty ? EntryTileBodyTextOnly(entry: entry)
              : EntryTileBodySingleImage(entry: entry),
        ],)
    );
    return InkWell(
        onTap: () => Get.toNamed(RouteConfig.entry, parameters: {"id": entry.id.toString()}),
        child: Obx((){
          return entry.isUnread ? child : Opacity(opacity: 0.5, child: child,);
        })
    );
  }
}

class EntryTileSkeleton extends StatelessWidget {
  const EntryTileSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        EntryTileHeaderSkeleton(),
        const SizedBox(height: 8,),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: EdgeInsets.only(top: 3, bottom: 3, right: 60),//设计图right100
              child: Container(height: 12, decoration: BoxDecoration(//设计图高14
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),),
            ),

            const SizedBox(height: 4,),

            Padding(padding: EdgeInsets.only(top: 3, bottom: 6),
              child: Container(height: 12, decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white,
              ),),
            ),

            Padding(padding: EdgeInsets.only(bottom: 3, right: 80), //设计图120
              child: Container(height: 12, decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white,
              ),),
            ),
            const SizedBox(height: 20,),
          ],)),
          const SizedBox(width: 24,),
          const SizedBox(width: 12,),
          Container(width: 80, height: 80, decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),),
        ],)
      ],),
    );
  }
}
