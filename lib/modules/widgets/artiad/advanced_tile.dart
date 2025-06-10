


import 'package:flutter/material.dart';
import 'package:follow_read/modules/widgets/acx/cupx_list_tile_chevron.dart';
import 'package:follow_read/modules/widgets/acx/menux.dart';
import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';
import 'package:follow_read/service/open.dart';

abstract class SelectableInterface {
  bool get hasSelection;
}

class SelectableWidget extends StatelessWidget implements SelectableInterface {

  final Widget child;
  final bool isSelected;
  const SelectableWidget({super.key, required this.child, this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    return child;
  }
  @override
  bool get hasSelection => isSelected;
}

class AdvancedTile extends StatelessWidget implements SelectableInterface {


  final String icon;
  final String title;
  final String selectedContent;
  final bool isSelected;
  final GestureTapCallback? openTickboxTap;
  final GestureTapCallback? clearTap;
  final GlobalKey localKey;
  const AdvancedTile({super.key, required this.icon, required this.title,
    required this.selectedContent, this.isSelected = false,
    this.openTickboxTap, this.clearTap, required this.localKey,
  });

  @override
  bool get hasSelection => isSelected;

  @override
  Widget build(BuildContext context) {
    Widget menu = RadioPopupMenu(
      menus: [
        MenuData(value: 'Off', text: 'Off', onTap: clearTap),
        MenuData(value: 'Custom', text: 'Custom', onTap: openTickboxTap),
      ],
      groupValue: isSelected ? 'Custom' : 'Off',
    );
    return Column(children: [
      ListTilexChevronUpDown(key: localKey, icon: icon, title: title,
        additionalInfo: isSelected ? 'Custom' : 'Off',
        onTap: () {
          if (isSelected) {
            Open.menu(context, localKey, menu);
            return;
          }
          openTickboxTap?.call();
        },
      ),
      if (isSelected) ...[
        const Padding(
          padding: EdgeInsets.only(left: 16 + 24 + 12, right: 12),
          child: SpacerDivider(thickness: 0.5, spacing: 1, indent: 0,),
        ),
        ListTilexChevron(
          additionalInfo: selectedContent,
          onTap: () => openTickboxTap?.call(),
        ),
      ]
    ],);
  }

}
