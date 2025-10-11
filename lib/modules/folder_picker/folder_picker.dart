

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/global/widgets/cupx_sheet_title.dart';
import 'package:follow_read/global/widgets/card_viewx.dart';
import 'package:follow_read/global/widgets/drag_handle.dart';
import 'package:follow_read/global/widgets/radiox_list_tile.dart';
import 'package:follow_read/modules/home/home_controller.dart';
import 'package:follow_read/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

///
class FolderPicker extends StatelessWidget {

  final String sheetTitle;
  final String value;
  final ValueChanged<BigInt>? onChanged;
  FolderPicker({super.key, required this.sheetTitle, this.value = "", this.onChanged});

  final homePage = Get.find<HomeController>();
  final profilePage = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SheetGrabber(),
      CenteredSheetTitle(
        title: sheetTitle,
        leading: CupxSheetTitleCloseButton(),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: CardView(
        child: Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: homePage.state.folderLen + 1,
          itemBuilder: (context, index) {
            final folder = index == 0
                ? profilePage.state.rootFolder
                : homePage.state.folders[index - 1];
            return RadioxListTile(icon: SvgIcons.group, title: folder.title, groupValue: value, onChanged: (v){
              onChanged?.call(folder.id);
              Get.back();
            },);
          },
        )),
      )),
      const SizedBox(height: 21,)
    ],);
  }

}