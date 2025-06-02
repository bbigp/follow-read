

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/folders_controller.dart';
import 'package:follow_read/features/presentation/providers/gen/add_feed.dart';
import 'package:follow_read/features/presentation/widgets/components/card_viewx.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sheet_title.dart';
import 'package:follow_read/features/presentation/widgets/components/drag_handle.dart';
import 'package:follow_read/features/presentation/widgets/components/radiox_list_tile.dart';
import 'package:get/get.dart';

///
class FolderSelector extends ConsumerWidget {

  const FolderSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = Get.find<FoldersController>();
    final addFeed = Get.find<AddFeedController>();
    return Column(children: [
      const SheetGrabber(),
      const CenteredSheetTitle(title: '选择文件夹'),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16),
        child: CardView(
          child: Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              Category folder = controller.folders[index];
              return RadioxListTile(icon: Svgicons.group, title: folder.title,
                groupValue: addFeed.folder.title,
                onChanged: (v) {
                  addFeed.changed(chooseFolder: folder);
                  Navigator.of(context).pop();
                },
              );
            },
            itemCount: controller.folders.length
          )),
        ),
      ),
      const SizedBox(height: 21,)
    ],);
  }

}