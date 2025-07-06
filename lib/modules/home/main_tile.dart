

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';
import 'package:follow_read/modules/widgets/home/provider/tile_data_provider.dart';



///
class MainTile extends StatelessWidget {

  final TileDataProvider provider;
  const MainTile({super.key, required this.provider, });

  @override
  Widget build(BuildContext context) {
    Widget view = Row(children: [
      const SizedBox(width: 4, height: 32,),
      provider.leadingIndicator.widget,
      const SizedBox(width: 4,),
    ]);
    //设计图是12  [24]  4  4 icon 扩大点击区域改成 8 [4 24 4]  4 icon
    Widget tile = InkWell(
      onTap: provider.onTap,
      child: Row(children: [
        const SizedBox(width: 8,),
        provider.leadingIndicator.onTap != null
            ? InkWell(onTap: provider.leadingIndicator.onTap, child: view)
            : view,

        const SizedBox(width: 4,),
        provider.icon,

        const SizedBox(width: 12, height: 52,),
        Expanded(child: Text(provider.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)),
        const SizedBox(width: 12,),

        // CountBadge(id: provider.id, counter: FeedCounter(),),

        const SizedBox(width: 16,), //设计图12
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