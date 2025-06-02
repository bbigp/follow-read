

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/cases/open.dart';
import 'package:follow_read/features/presentation/providers/gen/add_feed.dart';
import 'package:follow_read/features/presentation/widgets/components/buttonx.dart';
import 'package:follow_read/features/presentation/widgets/components/card_viewx.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_list_tile_chevron.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sheet_title.dart';
import 'package:follow_read/features/presentation/widgets/components/drag_handle.dart';
import 'package:follow_read/features/presentation/widgets/components/text_fieldx.dart';
import 'package:follow_read/features/presentation/widgets/feed/folder_selector.dart';
import 'package:follow_read/theme/text_styles.dart';
import 'package:get/get.dart';


class FeedCreator extends StatefulWidget {

  final int id;
  final bool shouldPop;

  const FeedCreator({super.key, this.id = 0, this.shouldPop = false,});

  @override
  State<StatefulWidget> createState() => _FeedCreatorState();

}

class _FeedCreatorState extends State<FeedCreator> {

  @override
  void initState() {
    super.initState();
    Get.put(AddFeedController(widget.id));
  }
  @override
  void dispose() {
    Get.delete<AddFeedController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddFeedController>();
    return Column(children: [
      const SheetGrabber(),
      const PlainSheetTitle(title: '添加Feed'),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(() => TextFieldx(sizex: Sizex.medium, hint: "Feed链接", value: controller.feed.feedUrl,
            readOnly: controller.isEditing, onChanged: (v) => controller.changed(url: v),
          )),
          if (controller.isEditing) ...[
            const SizedBox(height: 8,),
            Obx(() => TextFieldx(sizex: Sizex.medium, value: controller.feed.title,
              onChanged: (v) => controller.changed(title: v),
            )),
          ],
          const SizedBox(height: 8,),
          CardView(child: Obx(() => ListTilexChevron(icon: Svgicons.folder_1, title: "文件夹",
            additionalInfo: controller.folder.title,
            onTap: () => Open.modal(context, FolderSelector()),
          ))),
          const SizedBox(height: 16,),

          Obx(() => TextButtonx(child: 'Done', size: Sizex.large, enabled: controller.feedUrl.value.isNotEmpty,
            onPressed: () async {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FocusScope.of(context).unfocus(); // 收起键盘
              });
              final success = await controller.save();
              if (success) {
                Navigator.of(context).pop();
              }
            },
          )),
          if (controller.isEditing) ...[
            const SizedBox(height: 8,),
            IconButtonx(child: '取消订阅', icon: Svgicons.reduce_o,
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
        ],),
      ),
    ],);


  }

}