

import 'package:flutter/material.dart';
import 'package:follow_read/config/theme.dart';

class CupxSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CupxSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // CupertinoSwitch
    return GestureDetector(
      onTap: () => onChanged == null ? null : onChanged!(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 28,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          color: value ? AppTheme.black95 : AppTheme.black8,
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


// SizedBox(
//     height: 28, width: 48,
//     child: Transform.scale(
//       scale: 0.8, // 缩放比例 (0.8 对应默认尺寸的 80%)
//       child: Switch(
//         value: open,
//         padding: EdgeInsets.all(0),
//         thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
//           return Icon(Icons.circle, size: 20,
//             color: Colors.white,
//           );
//         }),
//         activeColor: Colors.white,      // 开启状态滑块颜色
//         activeTrackColor: AppTheme.black95, // 开启轨道颜色
//         inactiveThumbColor: Colors.white, // 关闭状态滑块颜色
//         inactiveTrackColor: AppTheme.black8, // 关闭轨道颜色
//         trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent), // 移除边框
//         trackOutlineWidth: const WidgetStatePropertyAll(0.0),
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 调整点击区域
//         onChanged: onChanged,
//       ),
//     )
// ),

// Transform.scale(
//   scale: 0.8, //原本默认大约是 59×31  48×28，大概需要 0.8 左右的缩放比例
//   child: CupertinoSwitch(
//     value: open,
//     activeTrackColor: AppTheme.black95,
//     inactiveTrackColor: AppTheme.black8,
//     thumbColor: Colors.white,
//     onChanged: onChanged,
//   ),
// ),