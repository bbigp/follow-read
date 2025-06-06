

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';
import 'package:follow_read/theme/text_styles.dart';

import 'spacer_divider.dart';



///重开
class ContextMenu implements ContextMenuEntry {

  final String label;
  final String icon;
  final ContextMenuType type;
  final VoidCallback? onTap;

  const ContextMenu({required this.label, required this.icon,
    this.type = ContextMenuType.normal,
    this.onTap,
  });

  @override
  Widget get() {
    return Row(children: [
      const SizedBox(width: 8, height: 44,),

      // const SizedBox(width: 20, height: 20,),

      const SizedBox(width: 8,),
      SizedBox(
        width: 160,
        child: Text(
          label, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: type == ContextMenuType.normal ? AppTextStyles.text : AppTextStyles.red,
        ),
      ),
      const SizedBox(width: 8,),

      const SizedBox(width: 4,),
      SvgPicture.asset(icon, width: 20, height: 20, colorFilter: ColorFilter.mode(
        type == ContextMenuType.normal ? AppTheme.black95 : AppTheme.red,
        BlendMode.srcIn,
      ),),
      const SizedBox(width: 4,),

      const SizedBox(width: 8,),
    ],);
  }

  @override
  VoidCallback? getTap() {
    return onTap;
  }

}

enum ContextMenuType { normal, warning, danger }

class ContextMenuDivider implements ContextMenuEntry {

  const ContextMenuDivider();

  @override
  Widget get() {
    return SizedBox(
      width: 240, height: 1,
      child: SpacerDivider(thickness: 1, spacing: 1, indent: 0,),
    );
  }

  @override
  VoidCallback? getTap() => null;
}