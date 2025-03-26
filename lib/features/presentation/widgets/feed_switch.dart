

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/presentation/providers/feed_loading_provider.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';

import '../../../config/theme.dart';
import '../providers/feed_detail_provider.dart';
import 'svgicon.dart';

class FeedSwitch extends ConsumerWidget {

  final int feedId;

  const FeedSwitch({super.key, required this.feedId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(feedDetailProvider(feedId));
    return feedAsync.when(data: (feed){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Svgicon(Svgicons.onlyUnread,),
                  Expanded(child: Padding(padding: EdgeInsets.only(left: 12, right: 12), child: Text(
                    '只显示未读', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    color: AppTheme.black95,
                  ),),)),
                  SizedBox(
                      height: 28, width: 48,
                      child: Transform.scale(
                        scale: 0.8, // 缩放比例 (0.8 对应默认尺寸的 80%)
                        child: Switch(
                          value: feed.onlyShowUnread,
                          padding: EdgeInsets.all(0),
                          thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
                            return Icon(Icons.circle, size: 20,
                              color: Colors.white,
                            );
                          }),
                          activeColor: Colors.white,      // 开启状态滑块颜色
                          activeTrackColor: AppTheme.black95, // 开启轨道颜色
                          inactiveThumbColor: Colors.white, // 关闭状态滑块颜色
                          inactiveTrackColor: AppTheme.black8, // 关闭轨道颜色
                          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent), // 移除边框
                          trackOutlineWidth: const WidgetStatePropertyAll(0.0),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 调整点击区域
                          onChanged: (v) {
                            ref.read(feedDetailProvider(feedId).notifier).saveShow(onlyShowUnread: v);
                            ref.read(feedLoadingProvider.notifier).getFeeds();
                          },
                        ),
                      )
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 20, left: 52),
              child: SpacerDivider(
                thickness: 0.5,
                spacing: 1,
                indent: 0,
                color: AppTheme.black8,
              ),
            ),
            Container(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Svgicon(Svgicons.readingTime),
                  Expanded(child: Padding(padding: EdgeInsets.only(left: 12, right: 12), child: Text(
                    '阅读时间', style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    color: AppTheme.black95,
                  ),),)),
                  SizedBox(
                      height: 28, width: 48,
                      child: Transform.scale(
                        scale: 0.8, // 缩放比例 (0.8 对应默认尺寸的 80%)
                        child: Switch(
                          value: feed.showReadingTime,
                          padding: EdgeInsets.all(0),
                          thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
                            return Icon(Icons.circle, size: 20,
                              color: Colors.white,
                            );
                          }),
                          activeColor: Colors.white,      // 开启状态滑块颜色
                          activeTrackColor: AppTheme.black95, // 开启轨道颜色
                          inactiveThumbColor: Colors.white, // 关闭状态滑块颜色
                          inactiveTrackColor: AppTheme.black8, // 关闭轨道颜色
                          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent), // 移除边框
                          trackOutlineWidth: const WidgetStatePropertyAll(0.0),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 调整点击区域
                          onChanged: (v){
                            ref.read(feedDetailProvider(feedId).notifier).saveShow(showReadingTime: v);
                          },
                        ),
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }, error: (_, stack) => const SizedBox.shrink(), loading: () => const SizedBox.shrink());
  }

}
