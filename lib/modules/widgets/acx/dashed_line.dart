
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/config/theme.dart';

///
class DashedDivider extends StatelessWidget {
  final Color color;
  final double dashLength;
  final double dashSpacing;
  final double thickness;//分割线粗细
  final double spacing;//空白模块总高度
  final double indent;//分割线左右边距

  const DashedDivider({
    super.key,
    this.color = AppTheme.black8, // 默认改为纯黑色
    this.thickness = 1, // 默认粗细调整为 2
    this.spacing = 16, //空白模块总高度
    this.indent = 0,
    this.dashLength = 5,
    this.dashSpacing = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: spacing,
      padding: EdgeInsets.symmetric(horizontal: indent),
      // 添加对齐，确保 CustomPaint 填满宽度
      alignment: Alignment.center,
      child: CustomPaint(
        size: Size.infinite, // 强制填充可用宽度
        painter: _DashedLinePainter(
          color: color,
          strokeWidth: thickness,
          dashLength: dashLength,
          dashSpacing: dashSpacing,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpacing;

  const _DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2; // 类型为 double
    double startX = 0.0; // 明确初始化为 double

    while (startX < size.width) {
      final double endX = startX + dashLength; // 显式声明为 double
      final double clampedEndX = endX.clamp(0.0, size.width); // 确保输入输出为 double

      canvas.drawLine(
        Offset(startX, centerY),
        Offset(clampedEndX, centerY),
        paint,
      );
      startX +=
          dashLength + dashSpacing; // dashLength 和 dashSpacing 需为 double 类型
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter old) {
    return color != old.color ||
        strokeWidth != old.strokeWidth ||
        dashLength != old.dashLength ||
        dashSpacing != old.dashSpacing;
  }
}
