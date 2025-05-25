

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/features/presentation/widgets/cluster/cluster_icon.dart';

import '../../../../config/cluster_icons.dart';
import '../../../../config/theme.dart';
import '../../pages/cluster_page.dart';
import '../input_field.dart';
import '../svgicon.dart';

class BasicView extends ConsumerWidget {

  const BasicView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cluster = ref.watch(clusterProvider);
    List<String> allIcons = ClusterIcons.iconMap.keys.toList();
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: AppTheme.white0,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(12),
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.white0,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: AppTheme.black8),
            ),
            child: SizedBox(width: 40, height: 40, child: ClusterIcon(icon: cluster.icon, size: 24,),),
          ),
          const SizedBox(width: 12,),
          Expanded(child: InputField(onChanged: (v) {
            if (cluster.name != v) {
              ref.read(clusterProvider.notifier).update(name: v);
            }
          }, hintText: '标题', data: cluster.name,
            contentPadding: EdgeInsets.only(left: 12, top: 10, bottom: 10),
            suffixIconPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ))
        ],),
      ),
      const SizedBox(height: 16,),
      Container(
        decoration: BoxDecoration(
          color: AppTheme.white0,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 12),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // 如果你希望外部控制滚动
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemCount: allIcons.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 40, // 每个图标最大宽度（可根据需求调整）
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            String icon = allIcons[index];
            return GestureDetector(
              onTap: () {
                ref.read(clusterProvider.notifier).update(icon: icon);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: icon == cluster.icon ? AppTheme.black8 : Colors.transparent,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: SizedBox(width: 40, height: 40, child: ClusterIcon(icon: icon, size: 24,),),
              ),
            );
          },
        ),
      )
    ],);
  }

}