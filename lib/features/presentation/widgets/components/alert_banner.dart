

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/widgets/feed/svg_icon_button.dart';
import 'package:follow_read/theme/text_styles.dart';

class AlertBanner extends StatelessWidget {

  const AlertBanner({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppTheme.red10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.all(4),
      child: Row(children: [
        const SizedBox(width: 4,),
        SvgPicture.asset(Svgicons.alertFill, width: 16, height: 16,),
        const SizedBox(width: 8,),
        Expanded(child: Text('', style: AppTextStyles.red13,),),
        const SizedBox(width: 8,),
        SvgIconButton(label: ''),
      ],),
    );
  }

}