import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/svgicons.dart';

class CircleRadio extends StatelessWidget {
  final bool choose; // 当前是否选中
  final ValueChanged<bool> onChanged; // 点击后传出新的状态
  final double size;

  const CircleRadio({
    super.key,
    this.choose = false,
    required this.onChanged,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    final iconPath = choose ? Svgicons.selection : Svgicons.circular;

    return GestureDetector(
      onTap: () {
        onChanged(!choose);
      },
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        iconPath,
        height: size,
        width: size,
      ),
    );
  }
}