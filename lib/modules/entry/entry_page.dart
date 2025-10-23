


import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/utils/copy.dart';
import 'package:follow_read/data/model/constant.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/global/widgets/menux.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/tab_barx.dart';
import 'package:follow_read/global/widgets/web_view.dart';
import 'package:follow_read/modules/display_setting/display_setting.dart';
import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:follow_read/modules/entry/entry_web.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:follow_read/modules/readable_content/reader_view.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'entry_controller.dart';
import 'entry_view.dart';

class EntryPage extends StatelessWidget {

  EntryPage({super.key});

  final esc = Get.find<EntriesController>();
  final profile = Get.find<ProfileController>();
  final GlobalKey _moreKey = GlobalKey();
  final ec = Get.find<EntryController>();

  @override
  Widget build(BuildContext context) {
    final entry = ec.get();

    Widget view = profile.state.user.openContent == User.OPEN_CONTENT_WEBVIEW
        ? WebView(url: entry.url)
        : Obx(() {
      final isReaderContentMissing = ec.isReaderMode && !ec.hasReadableContent;
      return isReaderContentMissing
          ? ReaderLoader(
        targetUrl: entry.url,
        onComplete: (extracted) {
          //pic: extracted.leadImageUrl
          ec.saveReadableContent(readableContent: extracted.content,
            summary: extracted.excerpt, leadImageUrl: extracted.leadImageUrl,
          );
        },
      )
          : SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: EntryView(entry: ec.get()),
      );



    });

    // Column(
    //         children: [
    //           Expanded(
    //             child: SingleChildScrollView(
    //             physics: const BouncingScrollPhysics(),
    //             child: Obx(() {
    //               final isReaderContentMissing = ec.isReaderMode && !ec.hasReadableContent;
    //               return isReaderContentMissing
    //                   ? ReaderLoader(
    //                       targetUrl: entry.url,
    //                       onComplete: (extracted) {
    //                         //pic: extracted.leadImageUrl
    //                         ec.saveReadableContent(readableContent: extracted.content,
    //                           summary: extracted.excerpt, leadImageUrl: extracted.leadImageUrl,
    //                         );
    //                       },
    //                     )
    //                   : EntryView(entry: ec.get());
    //             }),
    //           )),
    //         ],
    //       );

    final moreMenus = Menux(menus: [
      MenuItem(child: "使用浏览器打开", checkIcon: SvgIcons.explorer, onTap: () => Open.browser(entry.url),),
      MenuItem(child: "分享", checkIcon: SvgIcons.share, onTap: () => Share.share("${entry.title}\n${entry.url}"),),
      MenuItem(child: "复制链接", checkIcon: SvgIcons.link, onTap: () => Copy.clipboard(entry.url)),
      MenuItem(child: "阅读设置", checkIcon: SvgIcons.brush, onTap: () => Open.modal(context, DisplaySetting()),),
      // MenuItem(child: "tag", checkIcon: SvgIcons.explorer, onTap: () => Share.share("${entry.title}\n${entry.url}"),),
    ]);

    Widget child = Scaffold(
      body: SafeArea(child: Stack(children: [
        view,
        Positioned(
          left: 0, right: 0,
          bottom: 0, child: Obx((){
          final entry = ec.get();
          return TabBarx(tabs: [
            BottomBarItem(icon: SvgIcons.arrow_left, onPressed: () async =>  Get.back(),),
            BottomBarItem(
              icon: entry.isUnread ? SvgIcons.check_o : SvgIcons.check_fill,
              onPressed: () async => await esc.read(entry),
            ),
            BottomBarItem(
                icon: entry.starred ? SvgIcons.star_fill : SvgIcons.star,
                onPressed: () async => await esc.starred(entry),
            ),
            Obx((){
              return BottomBarItem(
                icon: ec.isReaderMode ? SvgIcons.page : SvgIcons.book, enabled: true,
                onPressed: () async  => ec.changeReaderMode(),
              );
            }),
            Obx((){
              return BottomBarItem(
                  icon: SvgIcons.chevron_down, enabled: ec.nextId != null,
                  onPressed: () async {
                    await Get.offNamed(RouteConfig.entry, parameters: {"id": ec.nextId.toString()});
                    Get.focusScope?.unfocus();
                    esc.autoRead(entry);
                  }
              );
            }),
            BottomBarItem(key: _moreKey, icon: SvgIcons.more, onPressed: () async => Open.menu(context, _moreKey, moreMenus)),
          ],);
        }),),

      ],)
    ));
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          esc.autoRead(entry);
        }
      },
      child: child,
    );
  }

}