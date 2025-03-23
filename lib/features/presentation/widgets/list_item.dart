
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/theme.dart';
import '../../domain/models/listx.dart';

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
            onTap: () {},
            leading: Icon(list.iconData, size: 24, color: AppTheme.black50,),
            title: Text(list.title,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                  color: AppTheme.black95,
                )),
            trailing: Text(
              '${list.unread > 0 ? list.unread : ''}',
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