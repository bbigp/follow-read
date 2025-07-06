

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';

///
class GroupTile extends StatelessWidget {

  final String title;
  final Widget? trailing;

  const GroupTile({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(width: 16, height: 28 + 8 + 8,),
      const SizedBox(width: 2,),
      Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text17500,)),
      const SizedBox(width: 2,),
      if (trailing case final Widget trailing) ...[
        const SizedBox(width: 12,),
        SizedBox(width: 28, height: 28, child: trailing,),
      ],
      const SizedBox(width: 16,),
    ],);
  }

}

class AddTrailing extends StatelessWidget {

  final GestureTapCallback? onTap;

  const AddTrailing({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(SvgIcons.plus_o, width: 24, height: 24, fit: BoxFit.contain,),
    );
  }

}