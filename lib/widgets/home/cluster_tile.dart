import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/app_route.dart';
import 'package:follow_read/theme/text_styles.dart';
import 'package:follow_read/widgets/acx/context_menu.dart';
import 'package:follow_read/widgets/cluster/cluster_icon.dart';
import 'package:follow_read/widgets/context_menu_wrapper.dart';

import 'count_badge.dart';

///
class ClusterTile extends ConsumerWidget {
  final Cluster artiad;

  const ClusterTile({
    super.key,
    required this.artiad,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContextMenuWrapper(
      menuItems: [
        ContextMenu(label: '编辑', icon: Svgicons.edit, onTap: () {
          ref.read(routerProvider).pushNamed(RouteNames.cluster, queryParameters: {
            'id': artiad.id.toString(),
          });
        }),
        const ContextMenuDivider(),
        ContextMenu(label: '删除', icon: Svgicons.trash, type: ContextMenuType.danger, onTap: () {
          ref.read(clusterRepositoryProvider).delete(artiad.id);
          // final _ = ref.refresh(homePageProvider);
        }),
      ],
      child: InkWell(
        onTap: () {
          ref.read(routerProvider).pushNamed(RouteNames.entry, pathParameters: {
              'id': artiad.id.toString(),
              'type': Model.artiad,
            },
          );
        },
        child: Row(children: [
          const SizedBox(width: 16, height: 44,),
          SizedBox(width: 24, height: 24, child: ClusterIcon(icon: artiad.icon, size: 24,),),
          const SizedBox(width: 16,),
          Expanded(child: Text(artiad.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.text500,)),
          const SizedBox(width: 16,),
          CountBadge(id: artiad.id, counter: ClusterCounter(),),
          const SizedBox(width: 16,),
        ],),
      )
    );
  }
}