
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../domain/models/tile.dart';
import 'context_menu_wrapper.dart';

class ClusterItem extends ConsumerWidget {
  
  final Cluster cluster;


  const ClusterItem({super.key, required this.cluster,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContextMenuWrapper(menuItems: [
      ContextMenuEntry(onTap: (){
        ref.read(routerProvider).pushNamed(
          RouteNames.cluster,
          queryParameters: {'id': cluster.id.toString(),},
        );
      }, child: Row(children: [
        SizedBox(width: 16, height: 44,),
        SizedBox(width: 160, child: Text('编辑', style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
        ),),),
        SizedBox(width: 8, height: 44,),
        SvgPicture.asset(Svgicons.edit, width: 20, height: 20,),
        SizedBox(width: 16, height: 44,),
      ],),),
      const ContextMenuEntry(child: SizedBox(width: 16 + 160 + 8 + 20 + 16, child: SpacerDivider(thickness: 1, spacing: 1, indent: 0,),)),
      ContextMenuEntry(onTap: (){
        ref.read(clusterRepository).delete(cluster.id);
        final _ = ref.refresh(homePageProvider);
      }, child: Row(children: [
        SizedBox(width: 16, height: 44,),
        SizedBox(width: 160, child: Text('删除', style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.red,
        ),),),
        SizedBox(width: 8, height: 44,),
        SvgPicture.asset(Svgicons.trashRed, width: 20, height: 20,),
        SizedBox(width: 16, height: 44,),
      ],),),
    ], child: SizedBox(
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
    ),);
  }

}