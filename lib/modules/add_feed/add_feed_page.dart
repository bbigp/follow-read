

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_text_styles.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/cupx_list_tile_chevron.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/pg_text.dart';
import 'package:follow_read/global/widgets/text_fieldx.dart';
import 'package:follow_read/modules/folder_picker/folder_picker.dart';
import 'package:follow_read/modules/home_tile/tile_card.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';
import 'package:get/get.dart';

import 'add_feed_controller.dart';

class AddFeedPage extends StatelessWidget {

  final controller = Get.find<AddFeedController>();

  AddFeedPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(SvgIcons.arrow_left, onTap: () => Get.back()),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CardView(child: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Obx((){
              final feed = controller.state.feed;
              return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(padding: EdgeInsets.only(top: 2),
                  child: FeedIcon(title: feed.title, iconUrl: feed.iconUrl, sizex: Sizex.large,),
                ),
                const SizedBox(width: 8,),
                Expanded(child: Column(children: [
                  Row(children: [
                    Expanded(child: PgText(feed.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.M17),),
                    const SizedBox(width: 20, height: 8,)
                  ],),
                  Row(children: [
                    Expanded(child: PgText(feed.feedUrl, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.R13B50),),
                    const SizedBox(width: 20, height: 8,)
                  ],),
                  if (feed.desc != "") ...[
                    const SizedBox(height: 4,),
                    Row(children: [
                      Expanded(child: PgText(feed.desc, maxLines: 2,
                          overflow: TextOverflow.ellipsis, style: AppTextStyles.R15),),
                      const SizedBox(width: 20, height: 8,)
                    ],),
                  ]
                ],)),
              ],);
            }),
          )),
          const SizedBox(height: 16,),
          Obx(() => TextFieldx(sizex: Sizex.medium, hint: "Feed链接", value: controller.state.feedUrl,
            readOnly: controller.id > BigInt.zero, onChanged: (v) => controller.changed(url: v),
          )),
          if (controller.id > BigInt.zero) ...[
            const SizedBox(height: 8,),
            Obx(() => TextFieldx(sizex: Sizex.medium, value: controller.state.feedTitle,
              onChanged: (v) => controller.changed(title: v),
            )),
          ],
          const SizedBox(height: 8,),
          CardView(child: Obx(() => ListTilexChevron(icon: SvgIcons.folder_1, title: "文件夹",
            additionalInfo: controller.state.folder.title,
            onTap: () => Open.modal(context, FolderPicker(
              sheetTitle: "选择文件夹", value: controller.state.folder.title,
              onChanged: (v) => controller.changed(folderId: v),
            )),
          ))),
          const SizedBox(height: 16,),

          Obx(() => TextButtonx(child: 'Done', size: Sizex.large, enabled: controller.state.feedUrl.isNotEmpty,
            onPressed: () async {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FocusScope.of(context).unfocus(); // 收起键盘
              });
              final success = await controller.save();
              if (success) {
                Get.back();
              }
            },
          )),
          if (controller.id > BigInt.zero) ...[
            const SizedBox(height: 8,),
            IconButtonx(child: '取消订阅', icon: SvgIcons.reduce_o,
              size: Sizex.medium, type: ButtonxType.dangerGhost, enabled: true,
              onPressed: () async {
                // OpenModal.open(context, AlertSheet(
                //   title: "确认取消订阅?",
                //   msg: "该订阅将从所有文件夹和列表中删除",
                //   onPressed: () async {
                //     var success = await ref.read(feedRepositoryProvider).removeFeed(add.feed.id);
                //     if (success) {
                //       // final _ = ref.refresh(homePageProvider);
                //       OpenModal.closeMultiple(context, count: widget.shouldPop ? 3 : 2);
                //     }
                //   },
                // ), scrollable: false, hasMargin: true);
              },
            ),
          ],
          const SizedBox(height: 16,),
        ],),),
      ),
    );
  }

}