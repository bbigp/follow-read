


import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/utils/copy.dart';
import 'package:follow_read/data/model/entry.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/element_type.dart';
import 'package:follow_read/global/widgets/menux.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/tab_barx.dart';
import 'package:follow_read/global/widgets/web_view.dart';
import 'package:follow_read/modules/display_setting/display_setting.dart';
import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:follow_read/modules/entry/entry_file.dart';
import 'package:follow_read/modules/entry/entry_video.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'entry_content.dart';
import 'entry_controller.dart';
import 'entry_image.dart';
import 'entry_title.dart';

class EntryPage extends StatelessWidget {

  EntryPage({super.key});

  final controller = Get.find<EntriesController>();
  final profile = Get.find<ProfileController>();
  final GlobalKey _moreKey = GlobalKey();
  final ec = Get.find<EntryController>();

  @override
  Widget build(BuildContext context) {
    final entryId = BigInt.parse(Get.parameters['id'] ?? "0");
    final entry = controller.state.get(entryId);

    Widget view = profile.state.user.openContent == User.OPEN_CONTENT_WEBVIEW
        ? WebView(url: entry.url)
        : Column(children: [
      Expanded(child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 48),
          child: Column(children: [
            const SizedBox(height: 30,),

            if (entry.pic.isNotEmpty) ...[
              EntryImage(url: entry.pic, height: 241, width: double.infinity, onTap: (){
                // ref.read(routerProvider).pushNamed(RouteNames.imageGallery, extra: {
                //   "imageUrls": entry.allImageUrls, "index": entry.allImageUrls.indexOf(entry.pic),
                // });
              },),
              const SizedBox(height: 12,),
            ],

            EntryTitle(entry: entry),
            const SizedBox(height: 12,),

            if (entry.medias.isNotEmpty) ...[
              Wrap(
                children: entry.medias.map((media) {
                  if (entry.pic == media.url) {
                    return const SizedBox.shrink();
                  }
                  if (media.isVideo) {
                    return EntryVideo(url: media.url);
                  }

                  if (media.isImage) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: EntryImage(url: media.url, boxFit: BoxFit.scaleDown, alignment: Alignment.topLeft,),
                    );
                  }
                  return EntryFile(url: media.url);
                }).toList(),
              ),
              const SizedBox(height: 12,),
            ],

            EntryContent(entry: entry),
            const SizedBox(height: 12,),

            const NoMore(),
            const SizedBox(height: 12,),

            const SizedBox(height: 8,),
            IconButtonx(
              child: "View Website", icon: SvgIcons.out_o,
              isLeftIcon: false,
              size: Sizex.custom,
              buttonSize: mediumCompact().copyWith(padding: 32,),
              type: ElementType.secondary,
              enabled: true,
              onPressed: () => Open.browser(entry.url),
            ),
            const SizedBox(height: 8,),
            const SizedBox(height: 48,),

            const SizedBox(height: 36,)//底部导航
          ],),
        ),
      )),
    ],);

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
          final entry = controller.state.get(entryId);
          return TabBarx(tabs: [
            BottomBarItem(icon: SvgIcons.arrow_left, onPressed: () async =>  Get.back(),),
            BottomBarItem(
              icon: entry.isUnread ? SvgIcons.check_o : SvgIcons.check_fill,
              onPressed: () async => await controller.read(entry),
            ),
            BottomBarItem(
                icon: entry.starred ? SvgIcons.star_fill : SvgIcons.star,
                onPressed: () async => await controller.starred(entry),
            ),
            BottomBarItem(icon: SvgIcons.book),
            Obx((){
              return BottomBarItem(
                  icon: SvgIcons.chevron_down, enabled: ec.nextId != null,
                  onPressed: () async {
                    await Get.offNamed(RouteConfig.entry, parameters: {"id": ec.nextId.toString()});
                    Get.focusScope?.unfocus();
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
          controller.autoRead(entry);
        }
      },
      child: child,
    );
  }

}