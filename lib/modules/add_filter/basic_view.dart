

import 'package:flutter/material.dart';
import 'package:follow_read/config/cluster_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/modules/add_filter/add_filter_controller.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/text_fieldx.dart';
import 'package:get/get.dart';

import 'filter_icon.dart';


class BasicView extends StatelessWidget {

  final AddFilterController controller;
  const BasicView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    List<String> allIcons = ClusterIcons.iconMap.keys.toList();
    return Column(children: [
      Padding(padding: EdgeInsets.only(top: 4, left: 16, right: 16), child: CardView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(children: [
            CardView(
              width: 44, height: 44,
              borderRadius: 12,
              border: Border.all(width: 1, color: AppColors.black08),
              child: SizedBox(width: 40, height: 40, child: Obx((){
                final icon = controller.state.icon;
                return FilterIcon(icon: icon.isNotEmpty ? icon : allIcons[0]);
              }),),
            ),
            const SizedBox(width: 12,),//设计图16
            Expanded(child: Obx((){
              return TextFieldx(
                sizex: Sizex.custom,
                value: controller.state.title,
                onChanged: (v) => controller.change(title: v),
              );
            })),
          ],)
      ),),
      Padding(padding: EdgeInsets.all(16), child: CardView(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemCount: allIcons.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 40, // 每个图标最大宽度（可根据需求调整）
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            String icon = allIcons[index];
            return GestureDetector(
              onTap: () => controller.change(icon: icon),
              child: Obx((){
                return Container(
                  decoration: BoxDecoration(
                    color: icon == controller.state.icon ? AppColors.black08 : Colors.transparent,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: SizedBox(width: 40, height: 40, child: FilterIcon(icon: icon),),
                );
              }),
            );
          },
        )
      ),),
    ],);
  }

}