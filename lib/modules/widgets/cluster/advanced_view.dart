

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/modules/pages/cluster_page.dart';
import 'package:follow_read/modules/widgets/acx/card_viewx.dart';
import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';

import '../../../../../config/theme.dart';
import 'feed_source.dart';
import 'recent_time.dart';
import 'statuses.dart';

class AdvancedView extends ConsumerWidget {

  const AdvancedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cluster = ref.watch(clusterProvider);

    final allFilters = ['feed', 'recentTime', 'status', 'recentAddTime'];
    final activeFilters = [];
    if (cluster.feedIds.isNotEmpty) activeFilters.add('feed');
    if (cluster.recentTime > 0) activeFilters.add('recentTime');
    if (cluster.recentAddTime > 0) activeFilters.add('recentAddTime');
    if (cluster.statuses.isNotEmpty) activeFilters.add('status');
    final inactiveFilters = allFilters.toSet().difference(activeFilters.toSet()).toList();

    return Column(children: [
      Visibility(
        visible: activeFilters.isNotEmpty, child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 8),
          itemBuilder: (context, index) {
            final t = activeFilters[index];
            if (t == 'feed') return CardView(child: FeedSource());
            if (t == 'recentTime') return CardView(child: RecentTime(label: '发布日期',));
            if (t == 'recentAddTime') return CardView(child: RecentTime(label: '添加日期'));
            if (t == 'status') return CardView(child: Statuses());
            return const SizedBox.shrink();
          },
          separatorBuilder: (_, __) => const SizedBox(height: 8,),
          itemCount: activeFilters.length
      )),

      Visibility(
        visible: inactiveFilters.isNotEmpty, child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: AppTheme.black4, width: 1),
        ),
        child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final t = inactiveFilters[index];
              if (t == 'feed') return FeedSource();
              if (t == 'recentTime') return RecentTime(label: '发布日期',);
              if (t == 'recentAddTime') return RecentTime(label: '添加日期');
              if (t == 'status') return Statuses();
              return const SizedBox.shrink();
            },
            separatorBuilder: (_, __) => _buildDivider(),
            itemCount: inactiveFilters.length
        ),
      ),),
    ],);
  }


  Widget _buildDivider(){
    return const Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12),
      child: SpacerDivider(
        thickness: 0.5,
        spacing: 1,
        indent: 0,
        color: AppTheme.black8,
      ),
    );
  }

}