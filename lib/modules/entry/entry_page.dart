


import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/data/model/user.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
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
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'entry_content.dart';
import 'entry_image.dart';
import 'entry_title.dart';

class EntryPage extends StatelessWidget{

  EntryPage({super.key});

  final controller = Get.find<EntriesController>();
  final profile = Get.find<ProfileController>();

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
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 48),
          child: Column(children: [
            if (entry.pic.isNotEmpty) ...[
              EntryImage(url: entry.pic, height: 241, width: double.infinity, onTap: (){
                // ref.read(routerProvider).pushNamed(RouteNames.imageGallery, extra: {
                //   "imageUrls": entry.allImageUrls, "index": entry.allImageUrls.indexOf(entry.pic),
                // });
              },),
              const SizedBox(height: 12,),
            ],
            EntryTitle(entry: entry),
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
              )
            ],
            const SizedBox(height: 12,),
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
              type: ButtonxType.secondary,
              enabled: true,
              onPressed: () => Open.browser(entry.url),
            ),
            const SizedBox(height: 8,),//设计图8
            const SizedBox(height: 48,), //设计图48
            const SizedBox(height: 36,)
          ],),
        ),
      )),
    ],);

    Widget child = Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(SvgIcons.arrow_left, onTap: () => Get.back()),
        actions: [
          PaddedSvgIcon(SvgIcons.more, onTap: () => Open.modal(context, DisplaySetting()),),
        ],
      ),
      body: Stack(children: [
        view,
        Positioned(
          left: 0, right: 0,
          bottom: 0, child: Obx((){
          final entry = controller.state.get(entryId);
          return TabBarx(tabs: [
            BottomBarItem(
                icon: entry.starred ? SvgIcons.star_fill : SvgIcons.star,
                onPressed: () async {
                  // await ref.read(entryProvider(entryId).notifier).starred();
                }
            ),
            BottomBarItem(
              icon: entry.isUnread ? SvgIcons.check_o : SvgIcons.check_fill,
              onPressed: () async {
                await controller.read(entryId);
              },
            ),
            BottomBarItem(icon: SvgIcons.chevron_down,),
            BottomBarItem(icon: SvgIcons.explorer, onPressed: () async {
              Open.browser(entry.url);
            },),
            BottomBarItem(icon: SvgIcons.share, onPressed: () async {
              Share.share("${entry.title}\n${entry.url}");
            },)
          ],);
        }),),

      ],)
    );
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          controller.autoRead(entryId);
        }
      },
      child: child,
    );
  }

}