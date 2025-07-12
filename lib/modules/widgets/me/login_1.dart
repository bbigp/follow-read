

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';

// class Login1 extends StatelessWidget {
//   const Login1({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Widget child = Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//
//       Stack(children: [
//         const SizedBox(height: 336, child: OnboardingBackground(),),
//         Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           const SizedBox(height: 103,),
//           const SizedBox(height: 22, child: Text('Probably your', maxLines: 1, style: AppTextStyles.caption17500,),),
//           const SizedBox(height: 6,),
//           const SizedBox(height: 34, child: Text('Better Reading', maxLines: 1, style: AppTextStyles.text20500,),),
//           const SizedBox(height: 34, child: Text('Experience', maxLines: 1, style: AppTextStyles.text20500,),),
//           const SizedBox(height: 34, child: Text('Workspace', maxLines: 1, style: AppTextStyles.text20500,),),
//           const SizedBox(height: 103,),
//         ],),),
//       ],),
//
//       Expanded(child: Container()),
//
//       CardView(
//         color: AppColors.black04,
//         padding: EdgeInsets.all(16),
//         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Container(decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//             padding: EdgeInsets.all(12),
//             child: SvgPicture.asset(Svgicons.into_collect, width: 24, height: 24, fit: BoxFit.contain,),
//           ),
//           const SizedBox(width: 16,),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('Collecting info is effortless', style: AppTextStyles.M15,),
//             Text('Aggregate content effortlessly from multiple sources.', style: AppTextStyles.R13B50,),
//           ],))
//         ],),
//       ),
//       const SizedBox(height: 8,),
//       CardView(
//         color: AppColors.black04,
//         padding: EdgeInsets.all(16),
//         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Container(decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//             padding: EdgeInsets.all(12),
//             child: SvgPicture.asset(Svgicons.into_breeze, width: 24, height: 24, fit: BoxFit.contain,),
//           ),
//           const SizedBox(width: 16,),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('Absorbing content is a breeze', style: AppTextStyles.M15,),
//             Text('Enjoy elegant reading with a wealth of view options.', style: AppTextStyles.R13B50,),
//           ],))
//         ],),
//       ),
//       const SizedBox(height: 8,),
//       CardView(
//         color: AppColors.black04,
//         padding: EdgeInsets.all(16),
//         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Container(decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//             padding: EdgeInsets.all(12),
//             child: SvgPicture.asset(Svgicons.ai, width: 24, height: 24, fit: BoxFit.contain,),
//           ),
//           const SizedBox(width: 16,),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text("And of course there's AI", style: AppTextStyles.M15,),
//             Text('Boost comprehension and efficiency with AI-assisted reading.', style: AppTextStyles.R13B50,),
//           ],))
//         ],),
//       ),
//       const SizedBox(height: 24,),
//
//       TextButtonx(child: "Continue", size: Sizex.large, enabled: true,),
//       const SizedBox(height: 24,),
//     ],),
//
//     );
//     return Scaffold(
//         // appBar: CupxAppBar(),
//         body: child
//     );
//   }
//
//
// }
//
// class OnboardingBackground extends StatelessWidget {
//   const OnboardingBackground({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white, // ✅ 加这个背景色才不会黑
//       child: CustomPaint(
//         painter: CircleLinesPainter(),
//         size: Size.infinite,
//       ),
//     );
//   }
// }
//
// class CircleLinesPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black.withOpacity(0.05)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1;
//
//     // 屏幕宽度
//     final width = size.width;
//
//     // 上方大圆（右上）
//     canvas.drawCircle(
//       Offset(width/2 + 77, 68), // 右上偏移
//       width/2,
//       paint,
//     );
//
//     // 左下大圆（左下）
//     canvas.drawCircle(
//       Offset(width/3 - 77, width/3 + 68), // 偏左偏下
//       width/3,               // 半径约为 60% 宽度
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
