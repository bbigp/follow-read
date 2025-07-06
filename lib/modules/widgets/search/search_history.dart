//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:follow_read/config/svg_icons.dart';
// import 'package:follow_read/config/theme.dart';
// import 'package:follow_read/features/domain/cases/base.dart';
// import 'package:follow_read/features/presentation/providers/search_provier.dart';
// import 'package:follow_read/features/presentation/widgets/components/no_more.dart';
// import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
// import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';
// import 'package:follow_read/features/presentation/widgets/search/no_search_history.dart';
// import 'package:follow_read/theme/app_text_styles.dart';
//
// ///
// class SearchHistory extends ConsumerWidget {
//
//   final MetaDatax metaDatax;
//   const SearchHistory({super.key, required this.metaDatax});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final historiesAsync = ref.watch(searchHistoriesProvider);
//     if (historiesAsync.isLoading) {
//       return NoSearchHistory();
//     }
//     final histories = historiesAsync.requireValue;
//     if (histories.isEmpty) {
//       return NoSearchHistory();
//     }
//     return Column(children: [
//       Padding(
//         padding: EdgeInsets.only(left: 16, right: 12, top: 4, bottom: 8),
//         child: Row(children: [
//           Expanded(child: Text('最近搜索', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.R13B50,)),
//           const SizedBox(width: 10, height: 24,),
//           InkWell(onTap: (){
//             ref.read(searchHistoriesProvider.notifier).clear();
//           }, child: PaddedSvgIcon(
//             Svgicons.trash, width: 20, height: 20,
//             colorFilter: ColorFilter.mode(AppTheme.black50, BlendMode.srcIn),
//           ),)
//         ],),
//       ),
//       Expanded(child: ListView.separated(
//           itemBuilder: (context, index) {
//             if (index == histories.length) {
//               return NoMore();
//             }
//             final word = histories[index];
//             return InkWell(onTap: (){
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 FocusScope.of(context).unfocus(); // 收起键盘
//               });
//               metaDatax.loadMore(ref, word: word);
//             }, child: Container(
//               height: 48,
//               padding: EdgeInsets.only(left: 16, right: 12),
//               child: Row(children: [
//                 Expanded(child: Text(word, maxLines: 1, overflow: TextOverflow.ellipsis,
//                   style: AppTextStyles.text,
//                 )),
//                 const SizedBox(width: 38 + 4 + 4,),
//                 const SizedBox(width: 4,),
//                 SvgPicture.asset(Svgicons.chevron_right, width: 20, height: 20, fit: BoxFit.contain,
//                   colorFilter: ColorFilter.mode(AppTheme.black25, BlendMode.srcIn),
//                 )
//               ],),
//             ));
//           },
//           separatorBuilder: (_, index) {
//             return SpacerDivider(thickness: 0.5,spacing: 1,indent: 16,);
//           },
//           itemCount: histories.length + 1,
//       ))
//     ],);
//   }
//
//
// }