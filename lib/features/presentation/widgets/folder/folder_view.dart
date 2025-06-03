

import 'package:flutter/material.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/models/folder.dart';
import 'package:follow_read/features/presentation/providers/gen/add_feed.dart';
import 'package:follow_read/features/presentation/widgets/components/radiox_list_tile.dart';
import 'package:get/get.dart';

// class FolderView extends StatelessWidget {
//   const FolderView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<FoldersController>();
//     final addFeed = Get.find<AddFeedController>();
//     return Obx(() => ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         itemBuilder: (context, index) {
//           Category folder = controller.folders[index];
//           return RadioxListTile(title: folder.title, groupValue: "",
//               onChanged: (v) {
//                 addFeed.changed(ch);
//                 Navigator.of(context).pop();
//               }, icon: Svgicons.group,
//           );
//         },
//         itemCount: controller.folders.length
//     ));
//   }
//
// }