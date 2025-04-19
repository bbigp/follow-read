

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/presentation/pages/cluster_page.dart';

import '../../../../config/svgicons.dart';
import '../../../../config/theme.dart';
import '../../../domain/models/cluster.dart';
import '../feed_popup_menu.dart';

class RecentTime extends ConsumerStatefulWidget {

  const RecentTime({super.key,});

  @override
  ConsumerState<RecentTime> createState() => _RecentTimeState();
}

class _RecentTimeState extends ConsumerState<RecentTime> {

  Offset? cachedPosition;
  Size? cachedSize;
  void _cachePosition() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    cachedPosition = renderBox.localToGlobal(Offset.zero);
    cachedSize = renderBox.size;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cachePosition(); // 页面绘制完毕后缓存一次
    });
  }

  @override
  Widget build(BuildContext context) {
    final recentTime = ref.watch(clusterProvider.select((s) => s.recentTime));
    return InkWell(onTap: (){
      //onTapDown: (details)
      // final RenderBox renderBox = context.findRenderObject() as RenderBox;
      // final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);  // 组件左上角位置
      // final Size widgetSize = renderBox.size;

      // 计算弹窗的出现位置：组件下方靠右
      // final Offset menuPosition = Offset(
      //   widgetPosition.dx + widgetSize.width, // 右侧
      //   widgetPosition.dy + widgetSize.height, // 下方
      // );
      final Offset menuPosition = Offset(
        cachedPosition!.dx + cachedSize!.width,
        cachedPosition!.dy + cachedSize!.height,
      );
      FeedPopupMenu.show(
        context: context,
        position: menuPosition,
        selected: Cluster.toRecentOption(recentTime),
        // width: widgetSize.width * 0.6,
        options: Cluster.recentOptions.values.toList(),
        onSelected: (val) {
          ref.read(clusterProvider.notifier).update(recentTime: Cluster.toRecentTime(val));
        },
      );
    }, child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16, height: 44,),
        SvgPicture.asset(Svgicons.calendarToday, width: 24, height: 24,),
        const SizedBox(width: 12,),
        const Expanded(child: Text("发布日期", style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
        ),)),
        const SizedBox(width: 4,),
        Text(Cluster.toRecentOption(recentTime), style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
        ),),
        const SizedBox(width: 4,),
        SvgPicture.asset(Svgicons.chevronUpDown, width: 20, height: 20,),
        const SizedBox(width: 12,),
      ],
    ),);
  }



}