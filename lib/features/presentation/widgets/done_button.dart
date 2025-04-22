import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class DoneButton extends StatefulWidget {
  const DoneButton(
      {super.key,
      this.width = double.infinity,
      this.height = 44,
      this.enabled = false,
      this.textStyle = const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        height: 1.29,
      ),
      this.borderRadius = const BorderRadius.all(Radius.circular(12)),
      required this.onPressed});

  final Future<void> Function()? onPressed;
  final double width;
  final double height;
  final bool enabled;
  final TextStyle textStyle;
  final BorderRadius borderRadius;

  @override
  State<DoneButton> createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  bool _isLoading = false;

  void _handlePress() async {
    if (_isLoading || widget.onPressed == null || !widget.enabled) return;

    setState(() {
      _isLoading = true; // 开始加载状态，禁用按钮
    });

    try {
      await widget.onPressed!(); // 执行传入的异步操作
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false; // 恢复加载状态
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.enabled ? _handlePress : null,
      style: ButtonStyle(
        minimumSize:
            WidgetStateProperty.all<Size>(Size(widget.width, widget.height)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: widget.borderRadius,
        )),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        textStyle: WidgetStateProperty.all<TextStyle>(widget.textStyle),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (_isLoading || !widget.enabled) {
              return AppTheme.black8; // 禁用状态
            }
            return AppTheme.black95;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (_isLoading || !widget.enabled) {
              return AppTheme.black25; // 禁用状态
            }
            return AppTheme.white0;
          },
        ),
      ),
      child: _isLoading
          ? Text(
              'Doing',
            )
          : Text(
              'Done',
            ),
    );
  }
}
