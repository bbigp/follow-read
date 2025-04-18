

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/svgicons.dart';
import '../../../../config/theme.dart';
import '../feed_popup_menu.dart';

class RecentTime extends StatefulWidget {

  final int recentTime;
  final Function(int)? onChanged;

  const RecentTime({super.key, this.recentTime = 0, this.onChanged});

  @override
  State<RecentTime> createState() => _RecentTimeState();
}

class _RecentTimeState extends State<RecentTime> {

  static const options = {0: 'Off', 1440: '最近24小时', 2880: '最近48小时',
  10080: '最近一周', 40320: '最近一个月'};
  String showTime = 'Off';

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
    showTime = options[widget.recentTime] ?? 'Off';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cachePosition(); // 页面绘制完毕后缓存一次
    });
  }

  @override
  Widget build(BuildContext context) {
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
        selected: showTime,
        // width: widgetSize.width * 0.6,
        options: options.values.toList(),
        onSelected: (val) {
          setState(() {
            showTime = val;
          });
          final int minutes = options.entries
              .firstWhere((e) => e.value == val, orElse: () => const MapEntry(0, 'Off'))
              .key;
          if (widget.onChanged != null) {
            widget.onChanged!(minutes);
          }
        },
      );
    }, child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16, height: 44,),
        SvgPicture.asset(Svgicons.calendarToday, width: 24, height: 24,),
        SizedBox(width: 12,),
        Expanded(child: Text("发布日期", style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
        ),)),
        SizedBox(width: 4,),
        Text(showTime, style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
        ),),
        SizedBox(width: 4,),
        SvgPicture.asset(Svgicons.chevronUpDown, width: 20, height: 20,),
        SizedBox(width: 12,),
      ],
    ),);
  }



}