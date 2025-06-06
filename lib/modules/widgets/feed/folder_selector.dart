

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/modules/controller/add_feed/add_feed_controller.dart';
import 'package:follow_read/modules/controller/folders/folders_controller.dart';
import 'package:follow_read/modules/widgets/acx/card_viewx.dart';
import 'package:follow_read/modules/widgets/acx/cupx_sheet_title.dart';
import 'package:follow_read/modules/widgets/acx/drag_handle.dart';
import 'package:follow_read/modules/widgets/acx/radiox_list_tile.dart';
import 'package:get/get.dart';

///
class FolderSelector extends ConsumerWidget {

  const FolderSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = Get.find<FoldersController>();
    final addFeed = Get.find<AddFeedController>();
    return Column(children: [
      const SheetGrabber(),
      const CenteredSheetTitle(title: '选择文件夹'),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CardView(
        child: Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: folders.state.folders.length,
          itemBuilder: (context, index) {
            final folder = folders.state.folders[index];
            return RadioxListTile(icon: Svgicons.group, title: folder.title,
              groupValue: addFeed.state.folder.title,
              onChanged: (v) {
                addFeed.changed(newFolder: folder);
                Navigator.of(context).pop();
              },
            );
          },
        )),
      )),
      const SizedBox(height: 21,)
    ],);
  }

}