

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/theme/text_styles.dart';

class UnsubscribeButton extends StatefulWidget {

  final Future<void> Function()? onPressed;

  const UnsubscribeButton({super.key, this.onPressed,});

  @override
  State<UnsubscribeButton> createState() => _UnsubscribeButtonState();

}

class _UnsubscribeButtonState extends State<UnsubscribeButton> {

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
        minimumSize: const Size.fromHeight(44),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 紧贴内容  避免外扩
        alignment: Alignment.center,
      ),
        child: Row(
          mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Svgicons.reduceO, width: 20, height: 20,),
            const SizedBox(width: 8,),
            Text('取消订阅', style: AppTextStyles.red500,)
          ],
        ),
    );
  }


}