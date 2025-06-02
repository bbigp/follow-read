

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/features/presentation/widgets/components/radiox.dart';
import 'package:follow_read/theme/text_styles.dart';


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
        const SizedBox(width: 12, height: 40,),
        PaddedSvgIcon(icon, padding: 4,),
        const SizedBox(width: 12,),
        Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)),
        const SizedBox(width: 12,),
        Radiox(value: title, groupValue: groupValue, onChanged: onChanged,),
        const SizedBox(width: 12,),
      ],
    ),);
  }


}