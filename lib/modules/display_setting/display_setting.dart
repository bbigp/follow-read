


import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/dashed_line.dart';
import 'package:follow_read/global/widgets/drag_handle.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

class DisplaySetting extends StatelessWidget {

  const DisplaySetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SheetGrabber(),
      // const CenteredSheetTitle(title: "显示设置",),
      const SizedBox(height: 8,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: PgText("背景色", maxLines: 1, style: AppTextStyles.M15B50),
      ),
      const SizedBox(height: 6,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Expanded(child: CardView(borderRadius: 10,
            color: Colors.white,
            border: Border.all(color: AppColors.black08, width: 0.5),
            child: SizedBox(height: 40, width: 67,),
          ))
          ,
          const SizedBox(width: 8,),
          Expanded(child: CardView(borderRadius: 10,
            color: AppColors.grep,
            border: Border.all(color: AppColors.black08, width: 0.5),
            child: SizedBox(height: 40, width: 67,),
          )),
          const SizedBox(width: 8,),
          Expanded(child: CardView(borderRadius: 10,
            color: AppColors.softPeach40,
            border: Border.all(color: AppColors.black08, width: 0.5),
            child: SizedBox(height: 40, width: 67,),
          )),
          const SizedBox(width: 8,),
          Expanded(child: CardView(borderRadius: 10,
            color: AppColors.darkSurface,
            border: Border.all(color: AppColors.black08, width: 0.5),
            child: SizedBox(height: 40, width: 67,),
          )),
          const SizedBox(width: 8,),
          Expanded(child: CardView(borderRadius: 10,
            color: AppColors.dark,
            border: Border.all(color: AppColors.black08, width: 0.5),
            child: SizedBox(height: 40, width: 67,),
          )),
        ],),
      ),
      const SizedBox(height: 16,),
      const DashedDivider(indent: 20, spacing: 1,),
      const SizedBox(height: 16,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: PgText("字体", maxLines: 1, style: AppTextStyles.M15B50),
      ),
      const SizedBox(height: 10,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Expanded(child: CardView(
            border: Border.all(color: AppColors.black95, width: 2),
            padding: EdgeInsets.all(12),
            child: Column(children: [
              PgText("Aa", maxLines: 1, style: AppTextStyles.M17),
              const SizedBox(height: 4,),
              PgText("Sans", maxLines: 1, style: AppTextStyles.M15),
            ],),
          )),
          const SizedBox(width: 8,),
          Expanded(child: CardView(
            color: AppColors.black04,
            border: Border.all(color: Colors.transparent, width: 2),
            padding: EdgeInsets.all(12),
            child: Column(children: [
              PgText("00", maxLines: 1, style: AppTextStyles.M17.copyWith(fontFamily: "DMMono")),
              const SizedBox(height: 4,),
              PgText("Mono", maxLines: 1, style: AppTextStyles.M15.copyWith(fontFamily: "DMMono")),
            ],),
          )),
        ],),
      ),
      const SizedBox(height: 21,),
    ],);
  }

}
