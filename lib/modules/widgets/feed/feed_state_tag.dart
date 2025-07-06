

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';

class FeedStateTag extends StatelessWidget {

  const FeedStateTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        color: AppColors.red10,
      ),
      child: Row(children: [
        const SizedBox(width: 6,),
        SvgPicture.asset(SvgIcons.rss_slash, width: 12, height: 12, fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(AppColors.red00, BlendMode.srcIn),
        ),
        const SizedBox(width: 2,),

        const SizedBox(width: 2,),
        Text('失效', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.red11500),
        const SizedBox(width: 2,),

        const SizedBox(width: 6,),
      ],),
    );
  }

}