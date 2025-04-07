
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../../config/theme.dart';
import '../../domain/models/listx.dart';
import '../../domain/models/tile.dart';

class ListItem extends ConsumerWidget {
  
  final Listx list;

  const ListItem({super.key, required this.list,});

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
                  pathParameters: {'id': list.id.toString(), 'type': TileType.list.toString()},
              );
            },
            leading: Svgicon(list.svgicon),
            title: Text(list.title,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                  color: AppTheme.black95,
                )),
            trailing: Text(
              '${list.count > 0 ? list.count : ''}',
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