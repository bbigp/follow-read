
import 'package:flutter/material.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';

class TabBarx extends StatelessWidget {

  final List<Widget> tabs; //点击区域扩大

  const TabBarx({super.key, required this.tabs,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(children: [
        SpacerDivider(spacing: 1, thickness: 1, indent: 0,),
        const SizedBox(height: 16,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(builder: (context, constraints){
            final totalSpacing = constraints.maxWidth - 28 * tabs.length;
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
        const SizedBox(height: 4,),
        const SizedBox(height: 12,),
      ],),
    );

  }
}