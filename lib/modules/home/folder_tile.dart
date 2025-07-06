//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:follow_read/features/domain/models/folder.dart';
// import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';
// import 'package:follow_read/modules/widgets/home/main_tile.dart';
//
// import 'provider/feed_provider.dart';
// import 'provider/folder_provider.dart';
//
// ///
// class FolderTile extends ConsumerWidget  {
//
//   final Category folder;
//   const FolderTile({super.key, required this.folder,});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(children: [
//       MainTile(provider: FolderProvider(folder, ref: ref)),
//       Padding(
//         padding: EdgeInsets.only(left: 12 + 24 + 4, right: 16),
//         child: SpacerDivider(thickness: 0.5, spacing: 0.5, indent: 0,),
//       ),
//       VerticalExpand(
//         expanded: folder.expanded,
//         child: ListView.builder(
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               final feed = folder.feeds[index];
//               return Column(children: [
//                 MainTile(provider: FeedProvider(feed, context: context, ref: ref, hasLeadingIndicator: false)),
//                 Padding(
//                   padding: EdgeInsets.only(left: 12 + 24 + 4, right: 16),
//                   child: SpacerDivider(thickness: 0.5, spacing: 0.5, indent: 0,),
//                 ),
//               ],);
//             },
//             itemCount: folder.feeds.length
//         ),
//       )
//     ],);
//   }
// }
//
// class VerticalExpand extends StatefulWidget {
//   final bool expanded;
//   final Widget child;
//   final Duration duration;
//
//   const VerticalExpand({
//     super.key,
//     required this.expanded,
//     required this.child,
//     this.duration = const Duration(milliseconds: 300),
//   });
//
//   @override
//   State<VerticalExpand> createState() => _VerticalExpandState();
// }
//
// class _VerticalExpandState extends State<VerticalExpand> with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.duration,
//     );
//     _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//
//     if (widget.expanded) {
//       _controller.value = 1.0;
//     }
//   }
//
//   @override
//   void didUpdateWidget(covariant VerticalExpand oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.expanded != oldWidget.expanded) {
//       if (widget.expanded) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRect(
//       child: SizeTransition(
//         axis: Axis.vertical,
//         axisAlignment: -1, // 关键！表示动画从上边开始展开和收缩
//         sizeFactor: _animation,
//         child: widget.child,
//       ),
//     );
//   }
// }
