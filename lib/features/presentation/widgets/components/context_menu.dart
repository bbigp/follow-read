

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/theme/text_styles.dart';

class ContextMenu extends StatelessWidget {

  final String label;
  final String icon;
  final TextStyle textStyle;

  const ContextMenu({super.key, required this.label, required this.icon,
    this.textStyle = AppTextStyles.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(width: 16, height: 44,),
      SizedBox(width: 160, child: Text(label, style: textStyle,),),
      const SizedBox(width: 8, height: 44,),
      SvgPicture.asset(icon, width: 20, height: 20,),
      const SizedBox(width: 16, height: 44,),
    ],);
  }


}