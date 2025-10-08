

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/global/widgets/dashed_line.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/modules/count_badge/unread_controller.dart';
import 'package:get/get.dart';

///
class EntriesSummary extends StatelessWidget {

  final controller = Get.find<UnreadController>();

  final Meta meta;
  EntriesSummary({super.key, required this.meta});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 8,),
        PgText(meta.title, maxLines: 1, style: AppTextStyles.M28,),
        Obx(() {
          final unread = controller.unread(meta.metaId);
          return unread > 0
              ? Column(children: [
                  const SizedBox(height: 4,),
                  const SizedBox(height: 2,),
                  Row(children: [
                    const SizedBox(width: 4,),
                    PgText('${unread > 999 ? "999+" : "$unread"}未读', maxLines: 1,
                      style: AppTextStyles.M11B25,
                      maxWidth: 50,
                    ),
                    const SizedBox(width: 4,),
                  ],)
              ],)
              : const SizedBox.shrink();
        }),
        const SizedBox(height: 16,),
        const DashedDivider(indent: 0, spacing: 16, thickness: 1, color: AppColors.black08,),
    ],),);
  }

}

class EntriesSummarySkeleton extends StatelessWidget {
  const EntriesSummarySkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 8,),
        Text('All', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.M28,),

        const SizedBox(height: 4,),
        Container(width: 70, height: 9, decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.white,
        ),),

        const SizedBox(height: 16,),
        const DashedDivider(indent: 0, spacing: 16, thickness: 1, color: Colors.white,),
      ],),
    );
  }
}