

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/theme/text_styles.dart';

class SvgIconButton extends StatefulWidget {

  final Future<void> Function()? onPressed;
  final double height;
  final String icon;
  final double iconSize;
  final TextStyle textStyle;
  final String label;

  const SvgIconButton({
    super.key, this.onPressed, this.height = 44, required this.label,
    this.icon = Svgicons.plusWhite, this.iconSize = 20,
    this.textStyle = AppTextStyles.white500,
  });

  @override
  State<SvgIconButton> createState() => _SvgIconButtonState();

}

class _SvgIconButtonState extends State<SvgIconButton> {

  bool _isLoading = false;

  void _handlePress() async {
    if (_isLoading || widget.onPressed == null) return;

    setState(() => _isLoading = true);
    try {
      await widget.onPressed!(); // 支持异步逻辑
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: _handlePress,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16), // 可选，调整左右间距
        minimumSize: Size(0, widget.height),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 紧贴内容  避免外扩
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: AppTheme.black95,
      ),
        child: Row(
          mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(widget.icon, width: widget.iconSize, height: widget.iconSize,),
            const SizedBox(width: 8,),
            Text(widget.label, style: widget.textStyle,)
          ],
        ),
    );
  }


}