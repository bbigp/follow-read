
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../../config/theme.dart';
import '../../domain/models/tile.dart';

class ClusterItem extends ConsumerWidget {
  
  final Cluster cluster;


  const ClusterItem({super.key, required this.cluster,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: ListTile(
            dense: true,
            horizontalTitleGap: 12,
            // 图标与标题的水平间距（默认16）
            onTap: () {
              ref.read(routerProvider).pushNamed(
                  RouteNames.entry,
                  pathParameters: {'id': cluster.id.toString(), 'type': TileType.cluster.toString()},
              );
            },
            onLongPress: (){
              ref.watch(routerProvider).pushNamed(RouteNames.cluster, queryParameters: {
                "id": cluster.id.toString(),
              });
            },
            leading: Svgicon(cluster.svgIcon),
            title: Text(cluster.name,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                  color: AppTheme.black95,
                )),
            trailing: Text(
              '${cluster.count > 0 ? cluster.count : ''}',
              // 这里可以是你想显示的任何数字
              style: const TextStyle(
                color: AppTheme.black25,
                fontSize: 13,
                height: 1.38,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ); 
  }

}