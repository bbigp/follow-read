

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/theme/text_styles.dart';

class FeedStateTag extends StatelessWidget {

  const FeedStateTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        color: AppTheme.red10,
      ),
      child: Row(children: [
        const SizedBox(width: 6,),
        SvgPicture.asset(Svgicons.rss_slash, width: 12, height: 12, fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(AppTheme.red, BlendMode.srcIn),
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