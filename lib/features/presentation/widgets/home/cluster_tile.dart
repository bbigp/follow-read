import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/widgets/cluster/cluster_icon.dart';
import 'package:follow_read/features/presentation/widgets/components/context_menu.dart';
import 'package:follow_read/features/presentation/widgets/context_menu_wrapper.dart';
import 'package:follow_read/features/presentation/widgets/home/count_badge.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:follow_read/theme/text_styles.dart';

///
class ClusterTile extends ConsumerWidget {
  final Cluster cluster;

  const ClusterTile({
    super.key,
    required this.cluster,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContextMenuWrapper(
      menuItems: [
        ContextMenu(label: '编辑', icon: Svgicons.edit, onTap: () {
          ref.read(routerProvider).pushNamed(RouteNames.cluster, queryParameters: {
            'id': cluster.id.toString(),
          });
        }),
        const ContextMenuDivider(),
        ContextMenu(label: '删除', icon: Svgicons.trash, type: ContextMenuType.danger, onTap: () {
          ref.read(clusterRepositoryProvider).delete(cluster.id);
          // final _ = ref.refresh(homePageProvider);
        }),
      ],
      child: InkWell(
        onTap: () {
          ref.read(routerProvider).pushNamed(RouteNames.entry, pathParameters: {
              'id': cluster.id.toString(),
              'type': TileType.cluster.toString()
            },
          );
        },
        child: Row(children: [
          const SizedBox(width: 16, height: 44,),
          SizedBox(width: 24, height: 24, child: ClusterIcon(icon: cluster.icon, size: 24,),),
          const SizedBox(width: 16,),
          Expanded(child: Text(cluster.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text500,)),
          const SizedBox(width: 16,),
          CountBadge(id: cluster.id, counter: ClusterCounter(),),
          const SizedBox(width: 16,),
        ],),
      )
    );
  }
}