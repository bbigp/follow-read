

import 'package:flutter/material.dart';
import 'package:follow_read/features/presentation/widgets/context_menu_wrapper.dart';
import 'package:follow_read/features/presentation/widgets/home/count_badge.dart';
import 'package:follow_read/theme/text_styles.dart';

import 'provider/tile_data_provider.dart';

///
class MainTile extends StatelessWidget {

  final TileDataProvider provider;
  const MainTile({super.key, required this.provider, });

  @override
  Widget build(BuildContext context) {
    Widget tile = InkWell(
      onTap: provider.onTap,
      child: Row(children: [
        const SizedBox(width: 12, height: 52,),

        provider.leadingIndicator,
        const SizedBox(width: 4,),

        const SizedBox(width: 4,),
        provider.icon,

        const SizedBox(width: 12,),
        Expanded(child: Text(provider.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)),
        const SizedBox(width: 12,),

        CountBadge(id: provider.id, counter: FeedCounter(),),

        const SizedBox(width: 12,),
      ],),
    );
    if (provider.contextMenus.isEmpty) {
      return tile;
    }
    return ContextMenuWrapper(
      menuItems: provider.contextMenus,
      child: tile,
    );
  }

}