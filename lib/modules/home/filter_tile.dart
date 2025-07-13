import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/data/model/filter.dart';
import 'package:follow_read/global/widgets/context_menu.dart';
import 'package:follow_read/modules/add_filter/filter_icon.dart';
import 'package:follow_read/modules/count_badge/count_badge.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

///
class FilterTile extends StatelessWidget {
  final Filter filter;
  final HomeController controller;
  const FilterTile({super.key, required this.filter, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ContextMenuWrapper(
      menuItems: [
        ContextMenu(
          label: '编辑', icon: SvgIcons.edit,
          onTap: () => Get.toNamed(RouteConfig.filter, parameters: {"id": filter.id.toString()}),
        ),
        const ContextMenuDivider(),
        ContextMenu(
          label: '删除', icon: SvgIcons.trash, type: ContextMenuType.danger,
          onTap: () => controller.deleteFilter(filter.id),
        ),
      ],
      child: InkWell(
        onTap: () => Get.toNamed(RouteConfig.entries, parameters: {"id": "i${filter.id}"}),
        child: Row(children: [
          const SizedBox(width: 16, height: 44,),
          SizedBox(width: 24, height: 24, child: FilterIcon(icon: filter.icon, size: 24,),),
          const SizedBox(width: 16,),
          Expanded(child: Text(filter.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.M15,)),
          const SizedBox(width: 16,),
          CountBadge(id: "i${filter.id}"),
          const SizedBox(width: 16,),
        ],),
      )
    );
  }
}