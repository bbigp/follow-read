//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:follow_read/config/svg_icons.dart';
// import 'package:follow_read/core/utils/page_utils.dart';
// import 'package:follow_read/features/presentation/providers/tile_provider.dart';
//
// import '../../features/domain/models/tile.dart';
// import 'preference_panel.dart';
//
// class FeedSwitch extends ConsumerWidget {
//
//   final int id;
//   final TileType type;
//
//   const FeedSwitch({super.key, required this.id, required this.type,});
//
//   String get pid => PageUtils.pid(type, id);
//
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tileState = ref.watch(tileProvider(pid));
//     return tileState.when(data: (tile){
//       var s1 = SwitchItem(icon: Svgicons.onlyUnread, label: '只显示未读',
//           value: tile.onlyShowUnread,
//           onChanged: (v){
//             ref.read(tileProvider(pid).notifier).saveShow(onlyShowUnread: v);
//             // final _ = ref.refresh(homePageProvider);
//           }
//       );
//       var s2 = SwitchItem(icon: Svgicons.readingTime, label: '阅读时间',
//         value: tile.showReadingTime,
//         onChanged: (v) => ref.read(tileProvider(pid).notifier).saveShow(showReadingTime: v),
//       );
//       var s3 = SwitchItem(icon: Svgicons.ban, label: '全局隐藏',
//           value: tile.hideGlobally,
//         onChanged: (v) {
//           ref.read(tileProvider(pid).notifier).saveShow(hideGlobally: v);
//           // final _ = ref.refresh(homePageProvider);
//         }
//       );
//       List<SwitchItem> items = [];
//       if (type == TileType.cluster && tile.cluster.statuses.length == 1) {
//         items = [s2, s3];
//       } else {
//         items = [s1, s2, s3];
//       }
//       return PreferencePanel(items: items,);
//     }, error: (_, stack) => const SizedBox.shrink(), loading: () => const SizedBox.shrink());
//   }
//
// }
