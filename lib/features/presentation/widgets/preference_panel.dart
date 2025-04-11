
import 'package:flutter/material.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/switch_tile.dart';

import '../../../config/theme.dart';

class PreferencePanel extends StatelessWidget {

  final List<SwitchItem> items;

  const PreferencePanel({super.key, required this.items,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,),
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => _buildDivider(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return SwitchTile(
            item.icon,
            item.label,
            open: item.value,
            onChanged: item.onChanged,
          );
        },
      ),
    );
  }


  Widget _buildDivider(){
    return Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12),
      child: SpacerDivider(
        thickness: 0.5,
        spacing: 1,
        indent: 0,
        color: AppTheme.black8,
      ),
    );
  }

}

class SwitchItem {
  final String icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  SwitchItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });
}