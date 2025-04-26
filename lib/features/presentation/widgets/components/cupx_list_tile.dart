

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/theme/text_styles.dart';

import 'cupx_switch.dart';

class CupxListTile extends StatefulWidget {

  factory CupxListTile.chevronUpDown({
    FutureOr<void> Function()? onTap,
    required String icon,
    required String title,
    String additionalInfo = "",
  }) {
    return CupxListTile(
        title: title,
        icon: icon,
        onTap: onTap,
        additionalInfo: additionalInfo,
        trailing: SvgPicture.asset(Svgicons.chevronUpDown, width: 20, height: 20,),
    );
  }

  factory CupxListTile.chevron({
    FutureOr<void> Function()? onTap,
    required String icon,
    required String title,
  }) {
    return CupxListTile(
      title: title,
      icon: icon,
      onTap: onTap,
      trailing: SvgPicture.asset(Svgicons.chevronRight, width: 20, height: 20,),
    );
  }

  factory CupxListTile.sswitch({
    ValueChanged<bool>? onChanged,
    required String icon,
    required String title,
    bool value = false,
  }) {
    return CupxListTile(
      title: title,
      icon: icon,
      trailing: CupxSwitch(value: value, onChanged: onChanged,),
    );
  }

  final FutureOr<void> Function()? onTap;
  final double height;
  final Color backgroundColor;
  final String icon;
  final String title;
  final String? additionalInfo;
  final Widget? trailing;
  final Color? backgroundColorActivated;//点击之后的背景颜色

  const CupxListTile({
    super.key,
    required this.title,
    required this.icon,
    this.height = 40,
    this.additionalInfo,
    this.trailing,
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.backgroundColorActivated,
  });

  @override
  State<CupxListTile> createState() => _CupxListTileState();
}

class _CupxListTileState extends State<CupxListTile> {

  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor = widget.backgroundColor;
    if (_tapped) {
      backgroundColor = widget.backgroundColorActivated ?? CupertinoColors.systemGrey4.resolveFrom(context);
    }

    final Widget child = Container(
      width: double.infinity,
      height: widget.height,
      color: backgroundColor,
      child: Row(children: [
        const SizedBox(width: 16,),
        SvgPicture.asset(widget.icon, height: 24, width: 24,),
        const SizedBox(width: 12,),
        Expanded(child: Text(widget.title, style: AppTextStyles.text,)),

        if (widget.additionalInfo case final String additionalInfo) ...<Widget>[
          const SizedBox(width: 12,),
          Text(additionalInfo, style: AppTextStyles.caption,),
          if (widget.trailing != null) const SizedBox(width: 8,),
        ],
        if (widget.trailing != null) widget.trailing!,
        const SizedBox(width: 12,),
      ],)
    );
    if (widget.onTap == null) {
      return child;
    }
    return GestureDetector(
      onTapDown: (_) => setState(() { _tapped = true; }),
      onTapCancel: () => setState(() { _tapped = false; }),
      onTap: () async {
        await widget.onTap!();
        if (mounted) {
          setState(() { _tapped = false; });
        }
      },
      behavior: HitTestBehavior.opaque,//让手势检测范围变成整个子组件区域，即使子组件是透明的，也能响应点击
      child: child,
    );
  }


}