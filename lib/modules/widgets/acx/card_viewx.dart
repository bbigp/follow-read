

import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxBorder? border;
  final double? height;
  final double? width;
  final Color? color;
  const CardView({super.key, required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
    this.margin = const EdgeInsets.all(0),
    this.border,
    this.height,
    this.width,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
          border: border,
        ),
        clipBehavior: Clip.antiAlias, // ✅ 让子组件也遵守圆角
        width: width, height: height,
        child: child
    );
  }
}