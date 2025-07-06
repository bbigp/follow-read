
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/modules/home/home_controller.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';
import 'package:get/get.dart';

import 'tile_data_provider.dart';


class FolderProvider implements TileDataProvider {
  final Category folder;
  final WidgetRef ref;
  const FolderProvider(this.folder, {required this.ref});

  @override
  int get id => folder.id;


  @override
  Widget get icon => SizedBox(width: 24, height: 24, child: SvgPicture.asset(SvgIcons.group, width: 24, height: 14, fit: BoxFit.contain,),);

  @override
  WidgetxBuilder get leadingIndicator => WidgetxBuilder(
    SizedBox(
      width: 24, height: 24,
      child: SvgPicture.asset(
        folder.expanded ? SvgIcons.triangle_down : SvgIcons.triangle_right, width: 24, height: 24, fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(AppColors.black50, BlendMode.srcIn,),
      ),
    ),
    onTap: () {
      Get.find<HomeController>().expanded(folder.id);
    }
  );

  @override
  String get title => folder.title;

  @override
  List<ContextMenuEntry> get contextMenus => const [];

  @override
  GestureTapCallback? get onTap => () {
    // ref.read(routerProvider).pushNamed(RouteNames.entry, pathParameters: {
    //   'id': folder.id.toString(),
    //   'type': Model.folder,
    // });
  };
}