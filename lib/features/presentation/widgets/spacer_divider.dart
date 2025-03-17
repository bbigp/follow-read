
import 'package:flutter/material.dart';

class SpacerDivider extends StatelessWidget {
  final Color color;
  final double thickness;//分割线粗细
  final double spacing;//空白模块总高度
  final double indent;//分割线左右边距

  const SpacerDivider({
    super.key,
    this.color = const Color(0x14000000),//8%透明度的黑色
    this.thickness = 1,
    this.spacing = 32,
    this.indent = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: spacing,
      alignment: Alignment.center,
      child: Divider(
        height: thickness,
        thickness: thickness,
        color: color,
        indent: indent,
        endIndent: indent,
      ),
    );
  }
}

