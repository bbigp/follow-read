

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/modules/widgets/acx/card_viewx.dart';
import 'package:follow_read/modules/widgets/acx/popup_wrapper.dart';
import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';
import 'package:follow_read/theme/text_styles.dart';


class MenuData {
  final String value;
  final String text;
  final GestureTapCallback? onTap;
  const MenuData({required this.value, required this.text, this.onTap});
}

class RadioPopupMenu extends StatelessWidget {
  final List<MenuData> menus;
  final String groupValue;
  const RadioPopupMenu({super.key, required this.menus, this.groupValue = ""});
  @override
  Widget build(BuildContext context) {
    final widgets = menus.expand((item) {
      final value = item.value;
      final text = item.text;
      return [
        RadioMenuItem(title: text, value: value, groupValue: groupValue, // 当前选中的 value
          onTap: () {
            item.onTap?.call();
            PopupWrapper.hide();
          },
        ),
        const MenuDivider(),
      ];
    }).toList();
    if (widgets.isNotEmpty) {
      widgets.removeLast();
    }
    return Menux(menus: widgets);
  }
}


class Menux extends StatelessWidget {

  final List<Widget> menus;
  const Menux({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {

    return CardView(width: 180, padding: EdgeInsets.zero, child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return menus[index];
      },
      itemCount: menus.length
    ));
  }

}


class MenuDivider extends StatelessWidget {
  final double thickness;
  const MenuDivider({super.key, this.thickness = 1});
  @override
  Widget build(BuildContext context) {
    return SpacerDivider(indent: 0, thickness: thickness, spacing: 0, color: AppTheme.black8,);
  }
}

class RadioMenuItem extends StatelessWidget {
  final String value;
  final String groupValue;
  final String? title;
  final GestureTapCallback? onTap;
  const RadioMenuItem({super.key, required this.value, required this.groupValue,
    this.onTap, this.title
  });
  @override
  Widget build(BuildContext context) {
    return MenuItem(child: title ?? value, icon: groupValue == value ? Svgicons.check : null, onTap: onTap,);
  }
}


class MenuItem extends StatelessWidget {
  final String? icon;
  final String child;
  final GestureTapCallback? onTap;
  const MenuItem({super.key, required this.child, this.icon, this.onTap});
  @override
  Widget build(BuildContext context) {
    Widget widget = SizedBox(
      height: 44,
      child: Row(children: [
        const SizedBox(width: 8,),
        icon == null
            ? const SizedBox(width: 20, height: 20,)
            : SvgPicture.asset(icon!, width: 20, height: 20, fit: BoxFit.contain,),

        const SizedBox(width: 8,),
        Text(child, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,),
        const SizedBox(width: 8,),

        const SizedBox(width: 8,),
      ],),
    );
    return onTap == null ? widget : InkWell(onTap: onTap, child: widget,);
  }

}