

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/theme/text_styles.dart';

class SvgIconButton extends StatefulWidget {

  final Future<void> Function()? onPressed;

  const SvgIconButton({super.key, this.onPressed,});

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
        minimumSize: const Size(0, 44),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 紧贴内容  避免外扩
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: AppTheme.black95,
      ),
        child: Row(
          mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Svgicons.plusWhite, width: 20, height: 20,),
            const SizedBox(width: 8,),
            Text('添加订阅', style: AppTextStyles.white500,)
          ],
        ),
    );
  }


}