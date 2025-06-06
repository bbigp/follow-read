

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/domain/cases/open.dart';
import 'package:follow_read/features/domain/models/constants.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/app_route.dart';
import 'package:follow_read/modules/widgets/acx/alert_sheet.dart';
import 'package:follow_read/modules/widgets/acx/context_menu.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';
import 'package:follow_read/modules/widgets/feed/feed_creator.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';
import 'package:follow_read/modules/widgets/home/count_badge.dart';
import 'package:follow_read/modules/widgets/open_modal.dart';

import 'tile_data_provider.dart';


class FeedProvider implements TileDataProvider {
  final Feed feed;
  final bool hasLeadingIndicator;
  final WidgetRef ref;
  final BuildContext context;
  const FeedProvider(this.feed, {required this.context, required this.ref, this.hasLeadingIndicator = true});

  @override
  int get id => feed.id;

  @override
  Counter get counter => FeedCounter();

  @override
  Widget get icon => FeedIcon(title: feed.title, iconUrl: feed.iconUrl, size: 24,);

  @override
  WidgetxBuilder get leadingIndicator => WidgetxBuilder(hasLeadingIndicator ? SizedBox(
    width: 24, height: 24,
    child: SvgPicture.asset(
      Svgicons.dot_s, width: 24, height: 24, fit: BoxFit.contain, //设计图dot_s半径1.5
      colorFilter: ColorFilter.mode(AppTheme.black50, BlendMode.srcIn,),//设计图black8
    ),
  ) : SizedBox(width: 24,)); //设计图36

  @override
  String get title => feed.title;

  @override
  List<ContextMenuEntry> get contextMenus => [
    ContextMenu(label: '编辑', icon: Svgicons.edit, onTap: (){
      Open.modal(context, FeedCreator(id: feed.id,));
    }),
    const ContextMenuDivider(),
    ContextMenu(label: "取消订阅", icon: Svgicons.reduce_o, type: ContextMenuType.danger, onTap: (){
      OpenModal.open(context, AlertSheet(
        title: "确认取消订阅?",
        msg: "该订阅将从所有文件夹和列表中删除",
        onPressed: () async {
          var success = await ref.read(feedRepositoryProvider).removeFeed(feed.id);
          if (success) {
            // final _ = ref.refresh(homeProvider);
            Navigator.of(context).pop();
          }
        },
      ), hasMargin: true);
    }),
  ];

  @override
  GestureTapCallback? get onTap => () {
    ref.read(routerProvider).pushNamed(RouteNames.entry, pathParameters: {
      'id': feed.id.toString(),
      'type': Model.feed
    });
  };

}