


import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/meta.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/pg_text.dart';

class TileCard extends StatelessWidget {

  final Meta meta;
  const TileCard({super.key, required this.meta});

  @override
  Widget build(BuildContext context) {

    return CardView(
        borderRadius: 16,
        color: Colors.transparent,
        border: Border.all(color: AppColors.black08, width: 1),
        padding: EdgeInsets.all(6),
        child: Row(children: [
          const SizedBox(width: 6,),
          const SizedBox(width: 36, height: 36,),

          const SizedBox(width: 12,),
          Expanded(child: PgText(meta.title, style: AppTextStyles.M15),),
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
        ],));
  }
}