

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';


class FilterView extends StatelessWidget {

  final String name;
  final String icon;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const FilterView({super.key, required this.name, required this.icon,
    this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16, height: 44,),
        SvgPicture.asset(icon, width: 24, height: 24,),
        const SizedBox(width: 12,),
        Expanded(child: Text(name, style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
        ),)),
        const SizedBox(width: 4,),
        Text(isSelected ? 'Custom' : 'Off', style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
        ),),
        const SizedBox(width: 4,),
        SvgPicture.asset(Svgicons.chevron_up_down, width: 20, height: 20,),
        const SizedBox(width: 12,),
      ],
    ),);
  }

}