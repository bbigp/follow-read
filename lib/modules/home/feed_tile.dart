//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:follow_read/features/domain/models/feed.dart';
// import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';
//
// import 'main_tile.dart';
// import 'provider/feed_provider.dart';
//
// ///
// class FeedTile extends ConsumerWidget {
//
//   final Feed feed;
//   const FeedTile({super.key, required this.feed});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(children: [
//       MainTile(provider: FeedProvider(feed, context: context, ref: ref)),
//       Padding(
//         padding: EdgeInsets.only(left: 12 + 24 + 4, right: 16),
//         child: SpacerDivider(thickness: 0.5, spacing: 0.5, indent: 0,),
//       ),
//     ],);
//   }
//
// }