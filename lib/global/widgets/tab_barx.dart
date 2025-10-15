
import 'package:flutter/material.dart';

import 'buttonx.dart';
import 'element_type.dart';
import 'spacer_divider.dart';

///
class TabBarx extends StatelessWidget {

  final List<Widget> tabs;

  const TabBarx({super.key, required this.tabs,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        color: Colors.white,
        child: Column(children: [
          SpacerDivider(spacing: 1, thickness: 1, indent: 0,),
          const SizedBox(height: 12,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(builder: (context, constraints){
              final totalSpacing = constraints.maxWidth - 36 * tabs.length;
              final eachSpacing = totalSpacing / (tabs.length - 1);
              List<Widget> widgets = [];
              for (var tab in tabs) {
                widgets.add(tab);
                widgets.add(SizedBox(width: eachSpacing,));
              }
              widgets.removeAt(widgets.length - 1);
              return Row(children: [
                ...widgets
              ],);
            }),
          ),
          // const SizedBox(height: 4,),
          const SizedBox(height: 12,),
        ],),
      )
    );

  }
}

class BottomBarItem extends StatelessWidget {
  final String icon;
  final Future<void> Function()? onPressed;
  final bool? enabled;
  const BottomBarItem({super.key, required this.icon, this.onPressed, this.enabled});

  @override
  Widget build(BuildContext context) {
    return IconButtonx(icon: icon,
      size: Sizex.custom, buttonSize: smallCompact().copyWith(padding: 0, width: 36, iconSize: 24),
      type: ElementType.ghost, enabled: enabled ?? onPressed != null,
      onPressed: onPressed,
    );
  }
}