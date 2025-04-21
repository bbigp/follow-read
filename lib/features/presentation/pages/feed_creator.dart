

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/pages/cluster_page.dart';
import 'package:follow_read/features/presentation/providers/feed_provider.dart';
import 'package:follow_read/features/presentation/providers/folder_provider.dart';
import 'package:follow_read/features/presentation/widgets/done_button.dart';
import 'package:follow_read/features/presentation/widgets/feed/folder_selector.dart';
import 'package:follow_read/features/presentation/widgets/input_field.dart';
import 'package:follow_read/features/presentation/widgets/open_modal.dart';

import '../../../theme/text_styles.dart';
import '../../domain/models/category.dart';

class FeedCreator extends ConsumerWidget {

  const FeedCreator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addFeedState = ref.watch(addFeedControllerProvider);
    if (addFeedState.isLoading) return const SizedBox.shrink();
    final add = addFeedState.requireValue;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: AppTheme.black8,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
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
          DoneButton(onPressed: (){}, height: 52, enabled: add.feedUrl.isNotEmpty,),
        ],),
      ),
    );
  }

}