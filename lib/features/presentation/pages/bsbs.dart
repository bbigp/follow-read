// import 'package:flutter/material.dart';
//
// import '../../../core/utils/logger.dart';
//
// class BouncyBalls extends StatelessWidget {
//   final double offset; // 添加 final 修饰符
//
//   const BouncyBalls({ // 添加 const 构造函数
//     super.key,
//     required this.offset,
//   }); // 修复缺少的括号和分号
//
//   Offset _mainBallOffset() {
//     if(offset > 20 && offset < 40) {
//       return Offset(
//         0, // 水平保持居中
//         0,
//       );
//     }
//     return Offset(
//       0, // 水平保持居中
//       (-(offset - 20)).clamp(-20, 0),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double stage1Distance = 20;//20距离出现小球
//     final double stage2Distance = 40;//40个出现第二小球
//     final double stage3Distance = 50;//小球停止运动
//     //小球left移动 10个
//     //top移动10个
//
//     logger.i('$offset');
//     return Container(
//       color: Colors.green,
//       child: SizedBox(
//         width: 80, height: offset,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             if(offset > 20)
//               // Transform.translate(
//               //   offset: Offset(0, 0),
//               //   child: const DecoratedBox(
//               //     decoration: BoxDecoration(
//               //       color: Colors.red,
//               //       shape: BoxShape.circle,
//               //     ),
//               //     child: SizedBox(width: 20, height: 20), // 保持原始尺寸
//               //   ),
//               // ),
//               // Transform.translate(
//               //   offset: _mainBallOffset(),
//               //   child: const DecoratedBox(
//               //     decoration: BoxDecoration(
//               //       color: Colors.black,
//               //       shape: BoxShape.circle,
//               //     ),
//               //     child: SizedBox(width: 20, height: 20), // 保持原始尺寸
//               //   ),
//               // ),
//               Positioned(
//                 top: (offset - 20).clamp(0, 20), // 使用 offset 参数
//                 left: 40 - (20/2),
//                 child: Center(
//                   child: const SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             if (offset > 40)//圆心top31
//               // Transform.translate(
//               //   offset: Offset(-14, -13),
//               //   child: const DecoratedBox(
//               //     decoration: BoxDecoration(
//               //       color: Colors.red,
//               //       shape: BoxShape.circle,
//               //     ),
//               //     child: SizedBox(width: 14, height: 14), // 保持原始尺寸
//               //   ),
//               // ),
//               Positioned(
//                 top: 26, // 使用 offset 参数
//                 left: 30,
//                 child: Transform.translate(
//                   offset: Offset(-14, -13),
//                   child: const DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       shape: BoxShape.circle,
//                     ),
//                     child: SizedBox(width: 14, height: 14), // 保持原始尺寸
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }