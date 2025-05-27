import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/presentation/widgets/entry/entry_tile_body_text_only.dart';
import 'package:follow_read/features/presentation/widgets/feed_icon.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:follow_read/theme/text_styles.dart';

import '../../../../config/svgicons.dart';
import '../../../../config/theme.dart';
import '../../../domain/models/entry.dart';
import '../../../domain/models/tile.dart';
import '../lazy_image.dart';
import 'entry_tile_body_single_image.dart';
import 'entry_tile_header.dart';

class EntryTile extends ConsumerWidget {
  final Entry entry;

  const EntryTile({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildContent(ref);
  }

  Widget _buildContent(WidgetRef ref) {
    Widget child = Container(
        color: Colors.white, padding: EdgeInsets.all(16),
        child: Column(children: [
          EntryTileHeader(title: entry.feed.title, iconUrl: entry.feed.iconUrl, time: entry.createdAt,),
          const SizedBox(height: 8,),
          entry.pic.isEmpty ? EntryTileBodyTextOnly(entry: entry)
              : EntryTileBodySingleImage(entry: entry),
        ],)
    );
    //已读加一个透明度百分之50的遮罩
    // return entry.isUnread
    //     ? EntryItem(entry: entry, tile: tile)
    //     : Opacity(opacity: 0.5,
    //         child: EntryItem(entry: entry, tile: tile),
    //       );
    return InkWell(onTap: (){
      ref.read(routerProvider).pushNamed(RouteNames.entryDetail, pathParameters: {
        'entryId': entry.id.toString(),
      });
    }, child: child,);
  }
}

