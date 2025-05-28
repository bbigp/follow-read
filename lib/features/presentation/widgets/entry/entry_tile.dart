import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/entry/entry_tile_body_text_only.dart';
import 'package:follow_read/routes/app_route.dart';

import 'entry_tile_body_single_image.dart';
import 'entry_tile_header.dart';

///
class EntryTile extends ConsumerWidget {
  final Entry entry;

  const EntryTile({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      _buildContent(ref),
      const SpacerDivider(indent: 16, spacing: 1, thickness: 0.5,),
    ],);
  }

  Widget _buildContent(WidgetRef ref) {
    Widget child = Container(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          EntryTileHeader(title: entry.feed.title, iconUrl: entry.feed.iconUrl, time: entry.createdAt,),
          const SizedBox(height: 8,),
          entry.pic.isEmpty ? EntryTileBodyTextOnly(entry: entry)
              : EntryTileBodySingleImage(entry: entry),
        ],)
    );
    return InkWell(onTap: (){
      ref.read(routerProvider).pushNamed(RouteNames.entryDetail, pathParameters: {
        'entryId': entry.id.toString(),
      });
    }, child: child,);
  }
}

class EntryTileSkeleton extends StatelessWidget {
  const EntryTileSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        EntryTileHeaderSkeleton(),
        const SizedBox(height: 8,),

        const SizedBox(height: 3,),

        const SizedBox(height: 3,),

      ],),
    );
  }
}



//已读加一个透明度百分之50的遮罩
// return entry.isUnread
//     ? EntryItem(entry: entry, tile: tile)
//     : Opacity(opacity: 0.5,
//         child: EntryItem(entry: entry, tile: tile),
//       );

