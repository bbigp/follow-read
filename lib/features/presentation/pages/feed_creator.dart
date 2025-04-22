

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/presentation/pages/cluster_page.dart';
import 'package:follow_read/features/presentation/providers/feed_provider.dart';
import 'package:follow_read/features/presentation/widgets/closable_bar.dart';
import 'package:follow_read/features/presentation/widgets/done_button.dart';
import 'package:follow_read/features/presentation/widgets/feed/folder_selector.dart';
import 'package:follow_read/features/presentation/widgets/input_field.dart';
import 'package:follow_read/features/presentation/widgets/open_modal.dart';

import '../../../theme/text_styles.dart';

class FeedCreator extends ConsumerWidget {

  const FeedCreator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(addFeedControllerProvider);
    if (controller.isLoading) return const SizedBox.shrink();
    final add = controller.requireValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        const SizedBox(height: 8,),
        const ClosableBar(title: '添加Feed', horizontal: 0,),
        const SizedBox(height: 8,),
        InputField(onChanged: (v){
          if (v != add.feedUrl) {
            ref.read(addFeedControllerProvider.notifier).addUrl(v);
          }
        }, hintText: 'URL',
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16,),
          height: 52, data: add.feedUrl,
        ),
        const SizedBox(height: 8,),
        CardView(child: InkWell(onTap: (){
          OpenModal.open(context, FolderSelector(), scrollable: true);
        }, child: Row(children: [
          const SizedBox(width: 16, height: 48,),
          SvgPicture.asset(Svgicons.folderBlack, width: 24, height: 24,),
          const SizedBox(width: 12,),
          Expanded(child: const Text('文件夹', style: AppTextStyles.text,)),
          const SizedBox(width: 12,),
          Text(add.folder.title, style: AppTextStyles.caption,),
          const SizedBox(width: 8,),
          SvgPicture.asset(Svgicons.chevronRight, width: 20, height: 20,),
          const SizedBox(width: 12,),
        ],),)),
        const SizedBox(height: 8,),
        const SizedBox(height: 8,),
        const SizedBox(height: 8,),
        DoneButton(onPressed: () async {
          final success = await ref.read(addFeedControllerProvider.notifier).save();
          if (success) {
            Navigator.of(context).pop();
          }
        }, height: 52, enabled: add.feedUrl.isNotEmpty,),
        const SizedBox(height: 21,),
      ],),
    );
  }

}