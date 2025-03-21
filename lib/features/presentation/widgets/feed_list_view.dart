// import 'package:flutter/material.dart';
// import 'package:follow_read/features/presentation/widgets/feed_icon_view.dart';
//
// import '../../data/models/feed.dart';
//
//
//
// class RssListSection extends StatelessWidget {
//   final List<Feed> items;
//   final bool isLoading;
//
//   const RssListSection({
//     super.key,
//     required this.items,
//     required this.isLoading,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
//           child: Text('订阅源',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF8B0000),
//               )),
//         ),
//         if (isLoading)
//           const Center(
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('加载中'),
//             ),
//           )
//         else
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               return ListTile(
//                 dense: true, // 使ListTile更紧凑
//                 horizontalTitleGap: 8, // 减小图标和文字之间的距离
//                 minLeadingWidth: 20, // 减小leading区域的最小宽度
//                 leading: item.icon != null
//                     ? FeedIconView(iconId: item.icon!.iconId)
//                     : const Icon(Icons.rss_feed),
//                 title: Text(item.title),
//                 trailing: Text(
//                   '${item.unread > 0 ? item.unread : ''}', // 这里可以是你想显示的任何数字
//                   style: const TextStyle(
//                     color: Color(0xFF8B0000),
//                     fontSize: 14,
//                   ),
//                 ),
//                 onTap: () async {
//                   // Navigator.pushNamed(context, AppRoutes.entryList);
//                   // AppRoutes.navigateTo(context, AppRoutes.entryList, arguments: item);
//                 },
//               );
//             },
//           ),
//       ],
//     );
//   }
// }
