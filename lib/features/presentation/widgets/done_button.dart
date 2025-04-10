

import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class DoneButton extends StatelessWidget {

  const DoneButton({super.key,
    this.width = double.infinity,
    required this.onPressed});

  final VoidCallback? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: true ? null : onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),)
        ),
        minimumSize: WidgetStateProperty.all<Size>(Size(width, 44)),
        textStyle: WidgetStateProperty.all<TextStyle>(
            TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, height: 1.29,
            )
        ),
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