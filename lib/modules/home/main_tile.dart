

import 'package:flutter/material.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';


///
class MainTile extends StatelessWidget {

  final Widget leadingIndicator;
  final Widget icon;
  final List<ContextMenuEntry> contextMenus;
  final String title;
  final GestureTapCallback? leadingIndicatorTap;
  final GestureTapCallback? onTap;
  const MainTile({super.key, this.onTap,
    required this.leadingIndicator, this.leadingIndicatorTap,
    required this.icon, this.contextMenus = const [], required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Widget view = Row(children: [
      const SizedBox(width: 4, height: 32,),
      leadingIndicator,
      const SizedBox(width: 4,),
    ]);
    //设计图是12  [24]  4  4 icon 扩大点击区域改成 8 [4 24 4]  4 icon
    Widget tile = InkWell(
      onTap: onTap,
      child: Row(children: [
        const SizedBox(width: 8,),
        leadingIndicatorTap != null
            ? InkWell(onTap: leadingIndicatorTap, child: view)
            : view,

        const SizedBox(width: 4,),
        icon,

        const SizedBox(width: 12, height: 52,),
        Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text,)),
        const SizedBox(width: 12,),

        // CountBadge(id: provider.id, counter: FeedCounter(),),

        const SizedBox(width: 16,), //设计图12
      ],),
    );
    if (contextMenus.isEmpty) {
      return tile;
    }
    return ContextMenuWrapper(
      menuItems: contextMenus,
      child: tile,
    );
  }

}