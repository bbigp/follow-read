

import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BoxBorder? border;
  final double? height;
  final double? width;
  const CardView({super.key, required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
    this.margin = const EdgeInsets.all(0),
    this.border,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
          border: border,
        ),
        clipBehavior: Clip.antiAlias, // ✅ 让子组件也遵守圆角
        width: width, height: height,
        child: child
    );
  }
}