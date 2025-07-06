// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:follow_read/config/svg_icons.dart';
// import 'package:follow_read/config/theme.dart';
// import 'package:follow_read/core/utils/page_utils.dart';
// import 'package:follow_read/features/domain/models/constants.dart';
// import 'package:follow_read/features/domain/models/tile.dart';
// import 'package:follow_read/features/presentation/providers/tile_provider.dart';
// import 'package:follow_read/global/widgets/card_viewx.dart';
// import 'package:follow_read/global/widgets/cupx_sliding_segmented_control.dart';
// import 'package:follow_read/global/widgets/drag_handle.dart';
// import 'package:follow_read/modules/widgets/feed/feed_form.dart';
// import 'package:follow_read/modules/widgets/feed_icon.dart';
// import 'package:follow_read/modules/widgets/feed_switch.dart';
// import 'package:follow_read/modules/widgets/open_modal.dart';
// import 'package:follow_read/theme/app_text_styles.dart';
//
//
// class FeedSettingsSheet extends ConsumerWidget {
//   final int id;
//   final TileType type;
//
//   const FeedSettingsSheet({
//     super.key,
//     required this.id,
//     required this.type,
//   });
//
//   String get pid => PageUtils.pid(type, id);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tileAsync = ref.watch(tileProvider(pid));
//     final tile = tileAsync.requireValue;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         DragHandle(),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           padding: EdgeInsets.all(6),
//           height: 60,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(width: 1, color: AppTheme.black8),
//           ),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 6,
//               ),
//               FeedIcon(
//                 title: tile.title,
//                 iconUrl: tile.iconUrl,
//                 size: 36,
//               ),
//               SizedBox(
//                 width: 12,
//               ),
//               Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         tile.title,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           height: 1.33,
//                           color: AppTheme.black95,
//                         ),
//                       ),
//                       if (tile.type == TileType.feed)
//                         Text(
//                           tile.feedUrl,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400,
//                             height: 1.38,
//                             color: AppTheme.black50,
//                           ),
//                         ),
//                     ],
//                   )),
//               SizedBox(
//                 width: 8,
//               ),
//               InkWell(
//                 onTap: () {
//                   if (tile.type == TileType.cluster) {
//                     // ref
//                         // .watch(routerProvider)
//                         // .pushNamed(RouteNames.cluster, queryParameters: {
//                       // "id": tile.id.toString(),
//                     // });
//                   }
//                   if (tile.type == TileType.feed) {
//                     Navigator.of(context).pop();
//                     OpenModal.open(context, FeedForm(id: tile.id, shouldPop: true,));
//                   }
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: AppTheme.black8,
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                   child: SvgPicture.asset(
//                     Svgicons.edit,
//                     height: 20,
//                     width: 20,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         const SizedBox(height: 16,),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Text('排序', style: AppTextStyles.caption500,),
//         ),
//         const SizedBox(height: 6,),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: CupxSlidingSegmentedControl.big(
//             groupValue: switch(tile.orderx) {
//               Model.orderxPublishedAt => '发布时间',
//               Model.orderxCreatedAt => '添加时间',
//               _ => '发布时间',
//             },
//             onValueChanged: (value) {
//               var v = switch(value) {
//                 '发布时间' => Model.orderxPublishedAt,
//                 '添加时间' => Model.orderxCreatedAt,
//                 _ => Model.orderxPublishedAt,
//               };
//               ref.read(tileProvider(pid).notifier).saveShow(orderx: v);
//             },
//             children: ['发布时间', '添加时间'],
//           ),
//         ),
//         const SizedBox(height: 16,),
//         const SizedBox(height: 8,),
//         FeedSwitch(
//           id: id,
//           type: type,
//         ),
//         const SizedBox(height: 16,),
//         const SizedBox(height: 8,),
//         Visibility(
//             visible: tile.type == TileType.feed,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text('Website', style: AppTextStyles.caption500,),
//             )
//         ),
//         Visibility(
//           visible: tile.type == TileType.feed,
//           child: CardView(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//               child: Text(tile.feed.siteUrl, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)
//           ),
//         ),
//         const SizedBox(height: 21,)
//       ],
//     );
//   }
//
// }
