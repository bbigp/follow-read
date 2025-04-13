
import 'package:flutter/material.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';

import '../../../config/theme.dart';

class HomeGroup extends StatelessWidget {

  final String title;
  final GestureTapCallback? onTap;
  final String rightIcon;

  const HomeGroup({super.key, required this.title, this.onTap, this.rightIcon = ""});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 12, height: 40,),
        Expanded(child: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            height: 1.29,
            color: AppTheme.black95,
          ),
        )),
        SizedBox(width: 12,),
        rightIcon != ''
            ? GestureDetector(
            onTap: onTap,
            child: Svgicon(rightIcon, size: 28, iconSize: 24,),
          ) : const SizedBox.shrink(),
        SizedBox(width: 16,),
      ],
    );
  }

}