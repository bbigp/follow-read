// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:follow_read/core/svg_icons.dart';
// import 'package:follow_read/core/themes/app_colors.dart';
// import 'package:follow_read/features/presentation/providers/user_provider.dart';
// import 'package:follow_read/global/widgets/drag_handle.dart';
//
// import '../../global/widgets/buttonx.dart';
// import 'svgicon.dart';
//
// class NewUrl extends ConsumerWidget  {
//
//   NewUrl({super.key});
//
//   final TextEditingController _controller = TextEditingController();
//   final _localTextProvider = StateProvider.autoDispose<String>((ref) => '');
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final urlText = ref.watch(_localTextProvider);
//     final enabled = urlText.isNotEmpty;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         DragHandle(),
//         Row(
//           children: [
//             GestureDetector(
//               onTap: () => _close(context),
//               child:  Svgicon(SvgIcons.arrow_left, size: 28, iconSize: 24,),
//             ),
//             Expanded(child: Text('新URL',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//               fontSize: 17, fontWeight: FontWeight.w500, height: 1.29, color: AppColors.black95,
//             ),)),
//             SizedBox(width: 28,),
//           ],
//         ),
//         SizedBox(height: 8,),
//         SizedBox(height: 12,),
//         TextField(
//           controller: _controller,
//           maxLines: 1,
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.black95,),
//           decoration: InputDecoration(
//             border: const OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//             ),
//             focusedBorder: const OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//             ),
//             fillColor: AppColors.black04,
//             filled: true,
//             hintText: 'http://***.***.com/v1/',
//             hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppColors.black25,),
//             suffixIcon: urlText.isNotEmpty ? GestureDetector(
//               onTap: (){
//                 _controller.clear();
//                 ref.read(_localTextProvider.notifier).state = '';
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 child: Svgicon(SvgIcons.x_fill, size: 28, iconSize: 24,),
//               ),
//             ) : null,
//           ),
//           textInputAction: TextInputAction.done,
//           keyboardType: TextInputType.url,
//           onChanged: (value){
//             ref.read(_localTextProvider.notifier).state = value;
//           },
//         ),
//         const SizedBox(height: 16),
//         TextButtonx(child: 'Done', size: Sizex.large, type: ButtonxType.primary, enabled: enabled, onPressed: () async {
//           if (await ref.read(userProvider.notifier).saveUrl(urlText)) {
//             if (!context.mounted) return;
//             _close(context);
//           }
//         },),
//         const SizedBox(height: 21),
//       ],
//     );
//   }
//
//   void _close(BuildContext context){
//     FocusScope.of(context).unfocus(); // 关闭键盘
//     Navigator.of(context).pop();      // 关闭 modal
//   }
// }
