

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/presentation/pages/cluster_page.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/feed_provider.dart';
import 'package:follow_read/features/presentation/widgets/components/alert_sheet.dart';
import 'package:follow_read/features/presentation/widgets/components/buttonx.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sheet_title.dart';
import 'package:follow_read/features/presentation/widgets/feed/folder_selector.dart';
import 'package:follow_read/features/presentation/widgets/input_field.dart';
import 'package:follow_read/features/presentation/widgets/open_modal.dart';

import '../../../../theme/text_styles.dart';

class FeedCreator extends ConsumerStatefulWidget {

  final int id;
  final bool shouldPop;

  const FeedCreator({super.key, this.id = 0, this.shouldPop = false,});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedCreatorState();

}

class _FeedCreatorState extends ConsumerState<FeedCreator> {

  @override
  void initState() {
    super.initState();
    if (widget.id != 0) {
      ref.read(addFeedControllerProvider.notifier).load(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(addFeedControllerProvider);
    if (controller.isLoading) return const SizedBox.shrink();
    final add = controller.requireValue;
    return Column(children: [
      const SizedBox(height: 8,),
      CupxSheetTitle.closeButton(title: '添加Feed', left: false, right: true,),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          const SizedBox(height: 8,),
          InputField(onChanged: (v){
            if (v != add.feed.feedUrl) {
              ref.read(addFeedControllerProvider.notifier).addUrl(v);
            }
          }, hintText: 'URL',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16,),
            height: 52, data: add.feed.feedUrl,
            readOnly: add.feed.id != 0,
          ),
          const SizedBox(height: 8,),
          Visibility(
            visible: add.feed.id != 0,
            child: InputField(onChanged: (v){
              if (v != add.feed.title) {
                ref.read(addFeedControllerProvider.notifier).updateFeed(title: v);
              }}, hintText: '标题',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16,),
              height: 52, data: add.feed.title,
            ),
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
            SvgPicture.asset(Svgicons.chevron_right, width: 20, height: 20,),
            const SizedBox(width: 12,),
          ],),)),
          const SizedBox(height: 8,),
          const SizedBox(height: 8,),
          const SizedBox(height: 8,),
          TextButtonx(child: 'Done',
            size: Sizex.large,
            enabled: add.feed.feedUrl.isNotEmpty, onPressed: () async {
              final success = await ref.read(addFeedControllerProvider.notifier).save();
              if (success) {
                setState(() {
                  Navigator.of(context).pop();
                });
              }
            },
          ),
          const SizedBox(height: 8,),
          Visibility(
            visible: add.feed.id != 0,
            child: IconButtonx(child: '取消订阅', icon: Svgicons.reduce_o,
              size: Sizex.medium, type: ButtonxType.dangerGhost,
              enabled: true,
              onPressed: () async {
                OpenModal.open(context, AlertSheet(
                  title: "确认取消订阅?",
                  msg: "该订阅将从所有文件夹和列表中删除",
                  onPressed: () async {
                    var success = await ref.read(feedRepositoryProvider).removeFeed(add.feed.id);
                    if (success) {
                      // final _ = ref.refresh(homePageProvider);
                      OpenModal.closeMultiple(context, count: widget.shouldPop ? 3 : 2);
                    }
                  },
                ), scrollable: false, hasMargin: true);
              },
            ),
          ),
          const SizedBox(height: 8,),
          const SizedBox(height: 21,),
        ],),
      )
    ],);


  }

}