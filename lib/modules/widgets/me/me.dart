

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';

class Me extends StatelessWidget {
  const Me({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(width: 4,),
      
      Image.asset(SvgIcons.avatar, width: 68, height: 69, fit: BoxFit.none,),
      const SizedBox(width: 16,),
      Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10,),
        Padding(padding: EdgeInsets.only(left: 2),
          child: Text('bigp', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text17500,),
        ),
        const SizedBox(height: 4,),
        CardView(
          borderRadius: 30,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Text('2024-05-04', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.M11B25,),
        ),
        const SizedBox(height: 10,)
      ],),),
      const SizedBox(width: 16,),

      const SizedBox(width: 8,),
      CardView(width: 30, height: 30,
        padding: EdgeInsets.zero,
        borderRadius: 99,
        color: AppColors.black04,
        child: SvgPicture.asset(SvgIcons.pencil, width: 20, height: 20, fit: BoxFit.none,),
      ),
      // const SizedBox(width: 16,),
      // CardView(width: 30, height: 30,
      //   padding: EdgeInsets.zero,
      //   borderRadius: 99,
      //   color: AppTheme.black4,
      //   child: SvgPicture.asset(Svgicons.pencil, width: 20, height: 20, fit: BoxFit.contain,),
      // ),
      const SizedBox(width: 8,),

      const SizedBox(width: 4,),
    ],);
  }

}