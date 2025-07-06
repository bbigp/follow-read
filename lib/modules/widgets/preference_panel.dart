//
// import 'package:flutter/material.dart';
//
// import '../../../../config/theme.dart';
// import '../../global/widgets/cupx_list_tile.dart';
// import 'acx/spacer_divider.dart';
//
// class PreferencePanel extends StatelessWidget {
//
//   final List<SwitchItem> items;
//   final EdgeInsets margin;
//
//   const PreferencePanel({super.key, required this.items,
//     this.margin = const EdgeInsets.symmetric(horizontal: 16,),
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: margin,
//       padding: EdgeInsets.symmetric(vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.white,
//       ),
//       child: ListView.separated(
//         shrinkWrap: true,
//         padding: EdgeInsets.zero,
//         physics: const NeverScrollableScrollPhysics(),
//         separatorBuilder: (_, __) => _buildDivider(),
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return CupxListTile.sswitch(
//             icon: item.icon, title: item.label, value: item.value,
//             onChanged: item.onChanged,
//           );
//         },
//       ),
//     );
//   }
//
//
//   Widget _buildDivider(){
//     return Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12),
//       child: SpacerDivider(
//         thickness: 0.5,
//         spacing: 1,
//         indent: 0,
//         color: AppTheme.black8,
//       ),
//     );
//   }
//
// }
//
// class SwitchItem {
//   final String icon;
//   final String label;
//   final bool value;
//   final ValueChanged<bool> onChanged;
//
//   SwitchItem({
//     required this.icon,
//     required this.label,
//     required this.value,
//     required this.onChanged,
//   });
// }