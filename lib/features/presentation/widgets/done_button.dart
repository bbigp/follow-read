

import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class DoneButton extends StatelessWidget {

  const DoneButton({super.key,
    this.width = double.infinity,
    this.height = 44,
    this.enabled = false,
    this.textStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500, height: 1.29,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    required this.onPressed});

  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool enabled;
  final TextStyle textStyle;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(Size(width, height)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: borderRadius,)
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        textStyle: WidgetStateProperty.all<TextStyle>(textStyle),
        backgroundColor:  WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppTheme.black8; // 禁用状态
            }
            return AppTheme.black95;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppTheme.black25; // 禁用状态
            }
            return AppTheme.white0;
          },
        ),
      ),
      child: Text('Done',),
    );
  }



}