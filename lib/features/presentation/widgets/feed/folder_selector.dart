

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/models/category.dart';
import 'package:follow_read/features/presentation/pages/cluster_page.dart';
import 'package:follow_read/features/presentation/widgets/closable_bar.dart';

import '../../providers/feed_provider.dart';
import '../../providers/folder_provider.dart';
import '../circle_radio_tile.dart';

class FolderSelector extends ConsumerWidget {

  const FolderSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersAsync = ref.watch(allFoldersProvider);
    if (foldersAsync.isLoading) return const SizedBox.shrink();
    var folders = List<Category>.from(foldersAsync.requireValue);
    folders.removeWhere((c) => c.title == "All");
    final all = foldersAsync.requireValue.firstWhere((c) => c.title == "All", orElse: () => Category.empty);
    folders.insert(0, all);

    final controller = ref.watch(addFeedControllerProvider);
    return Column(children: [
      const SizedBox(height: 8,),
      const ClosableBar(title: '选择文件夹'),
      CardView(margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            var folder = folders[index];
            return CircleRadioTile(
              icon: index == 0 ? Svgicons.folder : Svgicons.folderNoRss,
              value: folder.title,
              choose: controller.value?.folder.id == folder.id,
              leftPadding: index == 0 ? 12 : 28,
              fit: index == 0 ? BoxFit.contain : BoxFit.none,
              onTap: (){
                ref.read(addFeedControllerProvider.notifier).updateFolder(folder);
                Navigator.of(context).pop();
              },
            );
          },
          itemCount: folders.length
      )),
      const SizedBox(height: 21,)
    ],);
  }

}