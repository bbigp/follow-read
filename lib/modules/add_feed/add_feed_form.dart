

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/global/widgets/cupx_list_tile_chevron.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/element_type.dart';
import 'package:follow_read/modules/add_feed/add_feed_controller.dart';
import 'package:follow_read/global/widgets/buttonx.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/drag_handle.dart';
import 'package:follow_read/global/widgets/text_fieldx.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/modules/folder_picker/folder_picker.dart';
import 'package:get/get.dart';


class AddFeedForm extends StatelessWidget {

  final bool shouldPop;

  final controller = Get.find<AddFeedController>();

  AddFeedForm({super.key, this.shouldPop = false,});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SheetGrabber(),
      const PlainSheetTitle(title: '添加Feed'),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(() => TextFieldx(sizex: Sizex.medium, hint: "Feed链接", value: controller.state.feedUrl,
            readOnly: controller.feed.id > BigInt.zero, onChanged: (v) => controller.changed(url: v),
          )),
          if (controller.feed.id > BigInt.zero) ...[
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
          if (controller.feed.id > BigInt.zero) ...[
            const SizedBox(height: 8,),
            IconButtonx(child: '取消订阅', icon: SvgIcons.reduce_o,
              size: Sizex.medium, type: ElementType.dangerGhost, enabled: true,
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
        ],),
      ),
    ],);


  }

}