

import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  const CardView({super.key, required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
          // border: Border.all(color: AppTheme.black4, width: 1),
      ),
      child: child
    );
  }
}