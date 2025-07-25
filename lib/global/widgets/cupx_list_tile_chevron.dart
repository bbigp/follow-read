


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';

import 'cupx_switch.dart';
import 'pg_text.dart';

class ListTilexSwitch extends StatelessWidget {
  final String? icon;
  final String? title;
  final ValueChanged<bool>? onChanged;
  final bool value;
  const ListTilexSwitch({super.key, this.icon, required this.title, this.onChanged, this.value = false});
  @override
  Widget build(BuildContext context) {
    Widget child = Row(children: [
      const SizedBox(width: 16, height: 48,),
      icon == null
          ? const SizedBox(width: 24, height: 24,)
          : SvgPicture.asset(icon!, width: 24, height: 24, fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn),
      ),
      const SizedBox(width: 12,),
      if (title != null) ...[
        Expanded(child: PgText(title!, maxLines: 1, style: AppTextStyles.text,),),
        const SizedBox(width: 12,),
      ],

      const SizedBox(width: 4,),
      Switchx(value: value, onChanged: onChanged),
      const SizedBox(width: 4,),
      const SizedBox(width: 12,),
    ],);
    return child;
  }


}

class ListTilexChevronUpDown extends StatelessWidget {

  final String icon;
  final String title;
  final String additionalInfo;
  final GestureTapCallback? onTap;
  const ListTilexChevronUpDown({super.key, required this.icon,
    required this.title, this.onTap, this.additionalInfo = "",
  });

  @override
  Widget build(BuildContext context) {
    Widget? child = SvgPicture.asset(icon, width: 24, height: 24, fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn),
    );
    return ListTilex(
      icon: child, title: title,
      trailing: SvgPicture.asset(SvgIcons.chevron_up_down, width: 20, height: 20,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(AppColors.black25, BlendMode.srcIn),
      ),
      additionalInfo: additionalInfo,
      onTap: onTap,
    );
  }
}


class ListTilexChevron extends StatelessWidget {

  final String? icon;
  final String? title;
  final String additionalInfo;
  final GestureTapCallback? onTap;
  const ListTilexChevron({super.key, this.icon,
    this.title, this.onTap, this.additionalInfo = "",
  });

  @override
  Widget build(BuildContext context) {
    Widget? child = icon == null ? null : SvgPicture.asset(icon!, width: 24, height: 24, fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn),
    );
    return ListTilex(
      icon: child, title: title,
      trailing: SvgPicture.asset(SvgIcons.chevron_right, width: 20, height: 20,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(AppColors.black25, BlendMode.srcIn),
      ),
      additionalInfo: additionalInfo,
      onTap: onTap,
    );
  }
}

class ListTilex extends StatelessWidget {

  final Widget? icon;
  final String? title;
  final GestureTapCallback? onTap;
  final String additionalInfo;
  final Widget? trailing;
  const ListTilex({super.key, this.icon, this.title,
    this.onTap, this.additionalInfo = "", this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Row(children: [
      const SizedBox(width: 16, height: 48,),
      if (icon != null) ...[
        icon!,
        const SizedBox(width: 12,),
      ],
      if (title != null) ...[
        Text(title!, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,),
        const SizedBox(width: 12,),
      ],

      if (additionalInfo != "") ...[
        const SizedBox(width: 4),
        Expanded(child: Text(additionalInfo, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption,
          textAlign: TextAlign.right,)
        ),
        const SizedBox(width: 4,),
      ],

      if (trailing != null) ...[
        const SizedBox(width: 4,),
        trailing!,
      ],
      const SizedBox(width: 12,),
    ],);
    return onTap == null ? child : InkWell(onTap: onTap, child: child,);
  }

}
