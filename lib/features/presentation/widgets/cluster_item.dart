import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';
import 'package:follow_read/features/presentation/providers/unread_count_notifier.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:follow_read/theme/text_styles.dart';

import '../../../config/svgicons.dart';
import '../../domain/models/tile.dart';
import 'components/context_menu.dart';
import 'context_menu_wrapper.dart';

class ClusterItem extends ConsumerWidget {
  final Cluster cluster;

  const ClusterItem({
    super.key,
    required this.cluster,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContextMenuWrapper(
      menuItems: [
        ContextMenuEntry(
            onTap: () {
              ref.read(routerProvider).pushNamed(
                RouteNames.cluster,
                queryParameters: {
                  'id': cluster.id.toString(),
                },
              );
            },
            child: ContextMenu(
              label: '编辑',
              icon: Svgicons.edit,
            )),
        const ContextMenuEntry(
            child: SizedBox(
          width: 16 + 160 + 8 + 20 + 16,
          child: SpacerDivider(
            thickness: 1,
            spacing: 1,
            indent: 0,
          ),
        )),
        ContextMenuEntry(
          onTap: () {
            ref.read(clusterRepositoryProvider).delete(cluster.id);
            final _ = ref.refresh(homePageProvider);
          },
          child: ContextMenu(
            label: '删除',
            icon: Svgicons.trashRed,
            textStyle: AppTextStyles.red,
          ),
        ),
      ],
      child: SizedBox(
        height: 44,
        child: ListTile(
          dense: true,
          horizontalTitleGap: 12,
          // 图标与标题的水平间距（默认16）
          onTap: () {
            ref.read(routerProvider).pushNamed(
              RouteNames.entry,
              pathParameters: {
                'id': cluster.id.toString(),
                'type': TileType.cluster.toString()
              },
            );
          },
          leading: Svgicon(cluster.svgIcon),
          title: Text(
            cluster.name,
            maxLines: 1,
            style: AppTextStyles.text,
          ),
          trailing: ClusterUnreadView(clusterId: cluster.id,),
        ),
      ),
    );
  }
}

class ClusterUnreadView extends ConsumerWidget {

  final int clusterId;

  const ClusterUnreadView({super.key, required this.clusterId,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(clusterUnreadProvider(clusterId));
    return Text(count.isLoading || count.requireValue == 0 ? '' : count.requireValue.toString(), style: AppTextStyles.hint13500,);
  }

}