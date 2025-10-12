


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/element_type.dart';

import 'cupx_switch.dart';
import 'pg_text.dart';

class ListTilexText extends StatelessWidget {

  final GestureTapCallback? onTap;
  final String title;

  const ListTilexText({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 12,),
      Row(children: [
        Expanded(child: InkWell(onTap: onTap,
            child: PgText(title, maxLines: 1, style: AppTextStyles.R15,)
        )),
      ],),
      const SizedBox(height: 12,),
    ],);
  }

}


class ListTilexSwitch extends StatelessWidget {
  final String? icon;
  final String? title;
  final ValueChanged<bool>? onChanged;
  final bool value;
  const ListTilexSwitch({super.key, this.icon, required this.title, this.onChanged, this.value = false});
  @override
  Widget build(BuildContext context) {
    Widget child = Row(children: [
      const SizedBox(width: 16, height: 44,),
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

class ListTilexTextButton extends StatelessWidget {
  final String? icon;
  final String? title;
  final Future<void> Function()? onTap;
  final String action;
  const ListTilexTextButton({super.key, this.icon, this.title, this.onTap, required this.action});

  @override
  Widget build(BuildContext context) {
    Widget? child = icon == null ? null : SvgPicture.asset(icon!, width: 24, height: 24, fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn),
    );
    return ListTilex(
      icon: child, title: title,
      trailing: Buttonx(size: Sizex.custom, type: ElementType.primary, child: action,
        state: ButtonState.enabled, onPressed: onTap,
        buttonSize: smallCompact().copyWith(height: 30, padding: 8),
      ),
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
      const SizedBox(width: 16, height: 44,),
      if (icon != null) ...[
        icon!,
        const SizedBox(width: 12,),
      ],
      if (title != null) ...[
        PgText(title!, maxLines: 1, maxWidth: 300, overflow: TextOverflow.ellipsis, style: AppTextStyles.R15,),
        const SizedBox(width: 12,),
      ],

      if (additionalInfo != "") ...[
        const SizedBox(width: 4),
        Expanded(child: PgText(additionalInfo, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: AppTextStyles.caption,
          textAlign: icon == null && title == null ? TextAlign.start : TextAlign.right,)
        ),
        const SizedBox(width: 4,),
      ],
      if (additionalInfo == "")
        Expanded(child: const SizedBox()),


      if (trailing != null) ...[
        const SizedBox(width: 4,),
        trailing!,
      ],
      const SizedBox(width: 12,),
    ],);
    return onTap == null ? child : InkWell(onTap: onTap, child: child,);
  }

}
