
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/pages/cluster_page.dart';
import 'package:follow_read/features/presentation/widgets/closable_bar.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_button.dart';

import '../../../../config/svgicons.dart';
import '../../../../core/utils/logger.dart';

class SelectStatus extends ConsumerStatefulWidget {

  const SelectStatus({super.key,});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectStatusState();
}

class _SelectStatusState extends ConsumerState<SelectStatus> {

  List<String>? _statuses;


  @override
  Widget build(BuildContext context) {
    List<String> statuses = ref.watch(clusterProvider.select((s) => s.statuses));
    _statuses ??= List<String>.from(statuses);
    return Column(children: [
      const SizedBox(height: 8,),
      const ClosableBar(title: '选择状态'),
      FilterCard(title: '未读', icon: Svgicons.markUnread, isSelected: (_statuses ?? []).contains('unread'), onTap: (){
        if ((_statuses ?? []).contains('unread')) {
          (_statuses ?? []).remove('unread');
        } else {
          (_statuses ?? []).add('unread');
        }
        setState(() {});
      },),
      FilterCard(title: '已读', icon: Svgicons.markRead, isSelected: (_statuses ?? []).contains('read'), onTap: (){
        logger.i('$_statuses');
        if ((_statuses ?? []).contains('read')) {
          (_statuses ?? []).remove('read');
        } else {
          (_statuses ?? []).add('read');
        }
        logger.i('$_statuses');
        setState(() {});
      },),
      const SizedBox(height: 16,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: CupxButton.text('Done', style: CupxButtonStyle.primaryLarge,
          enabled: (_statuses ?? []).isNotEmpty,
          onPressed: () async {
            ref.read(clusterProvider.notifier).update(statuses: _statuses);
            Navigator.of(context).pop();
          }
        )
      ),
      const SizedBox(height: 21,),
    ],);
  }

}

class FilterCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String icon;
  final GestureTapCallback? onTap;
  const FilterCard({super.key, this.isSelected = false,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Container(
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: AppTheme.black95, width: 1.5,)
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 24, height: 24,),
          Expanded(child: Center(child: Text(title, style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black95,
          ),),),),
          SvgPicture.asset(
            isSelected ? Svgicons.selection : Svgicons.circular,
            height: 28,
            width: 28,
          ),
        ],),
    ),);
  }
}