

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';

class CircleRadioTile extends StatelessWidget {

  final String value;
  final bool choose;
  final double leftPadding;
  final String icon;
  final BoxFit fit;
  final GestureTapCallback? onTap;

  const CircleRadioTile({super.key,
    required this.value, this.choose = false,
    this.leftPadding = 12,
    this.icon = Svgicons.folder,
    this.fit = BoxFit.contain,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      HapticFeedback.lightImpact();
      onTap?.call();
    }, child: Row(
      children: [
        SizedBox(width: leftPadding, height: 40,),
        Svgicon(icon, size: 32, iconSize: 24, fit: fit,),
        const SizedBox(width: 12,),
        Expanded(child: Text(value, style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
        ),)),
        const SizedBox(width: 12,),
        SvgPicture.asset(
          choose ? Svgicons.selection : Svgicons.circular,
          height: 28,
          width: 28,
        ),
        const SizedBox(width: 12,),
      ],
    ),);
  }


}