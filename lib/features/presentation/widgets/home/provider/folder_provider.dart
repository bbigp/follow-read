
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';
import 'package:follow_read/features/presentation/widgets/context_menu_wrapper.dart';
import 'package:follow_read/features/presentation/widgets/home/count_badge.dart';
import 'package:follow_read/routes/app_route.dart';

import 'tile_data_provider.dart';

class FolderProvider implements TileDataProvider {
  final Category folder;
  final WidgetRef ref;
  const FolderProvider(this.folder, {required this.ref});

  @override
  int get id => folder.id;

  @override
  Counter get counter => FolderCounter();

  @override
  Widget get icon => SizedBox(width: 24, height: 24, child: SvgPicture.asset(Svgicons.group, width: 24, height: 14, fit: BoxFit.contain,),);

  @override
  Widget get leadingIndicator => InkWell(
    onTap: () {
      ref.read(homePageProvider.notifier).expanded(folder.id);
    },
    child: SizedBox(
      width: 24, height: 24,
      child: SvgPicture.asset(
        folder.expanded ? Svgicons.triangle_down : Svgicons.triangle_right, width: 24, height: 24, fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(AppTheme.black50, BlendMode.srcIn,),
      ),
    ),
  );

  @override
  String get title => folder.title;

  @override
  List<ContextMenuEntry> get contextMenus => const [];

  @override
  GestureTapCallback? get onTap => () {
    ref.read(routerProvider).pushNamed(RouteNames.entry, pathParameters: {
      'id': folder.id.toString(),
      'type': TileType.folder.toString(),
    });
  };
}