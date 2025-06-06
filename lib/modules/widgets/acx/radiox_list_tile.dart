

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/theme/text_styles.dart';

import 'radiox.dart';



class RadioxListTile extends StatelessWidget {


  final ValueChanged<String>? onChanged;
  final String icon;
  final String title;
  final String groupValue;
  
  
  const RadioxListTile({super.key,
    required this.title,
    required this.icon,
    required this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      HapticFeedback.mediumImpact();
      onChanged?.call(title);
    }, child: Row(
      children: [
        const SizedBox(width: 16, height: 40,),
        SvgPicture.asset(icon, width: 24, height: 24, fit: BoxFit.scaleDown,),
        const SizedBox(width: 16,),
        Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)),
        const SizedBox(width: 12,),
        Radiox(value: title, groupValue: groupValue, onChanged: onChanged,),
        const SizedBox(width: 12,),
      ],
    ),);
  }


}