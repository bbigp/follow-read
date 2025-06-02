

import 'package:flutter/material.dart';

///
class CupxAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double height;
  final String title;
  final Widget leading;
  final List<Widget> actions;
  const CupxAppBar({super.key, this.height = 50.0, this.title = "",
    this.leading = const SizedBox(width: 28, height: 28,),
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionWidgets = actions.isEmpty
        ? []
        : [
      const SizedBox(width: 4),
      ..._intersperse(actions, const SizedBox(width: 12)), //设计图16
      const SizedBox(width: 4),
    ];
    return SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Row(children: [
            SizedBox(width: 12, height: height,),

            leading,

            Expanded(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,)),
            const SizedBox(width: 12,),

            ...actionWidgets,

            const SizedBox(width: 12,),
          ],),
        )
    );
  }

  List<Widget> _intersperse(List<Widget> widgets, Widget spacer) {
    if (widgets.length <= 1) return widgets;
    final List<Widget> result = [];
    for (int i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);
      if (i < widgets.length - 1) {
        result.add(spacer);
      }
    }
    return result;
  }


  @override
  Size get preferredSize => Size.fromHeight(height);

}