

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import 'feed_popup_menu.dart';

class FeedSource extends StatefulWidget {

  final String icon;
  final String title;

  const FeedSource({super.key,
    required this.icon,
    required this.title,
  });

  @override
  State<StatefulWidget> createState() => _FeedSourceState();
}

class _FeedSourceState extends State<FeedSource> {

  String _selected = 'Off';

  @override
  Widget build(BuildContext context) {
    logger.i('build $_selected');
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 16, height: 44,),
          SvgPicture.asset(widget.icon, width: 24, height: 24,),
          SizedBox(width: 12,),
          Expanded(child: Text(widget.title, style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
          ),)),
          GestureDetector(
            onTapDown: (details) {
              final RenderBox renderBox = context.findRenderObject() as RenderBox;
              final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);  // 组件左上角位置
              final Size widgetSize = renderBox.size;

              // 计算弹窗的出现位置：组件下方靠右
              final Offset menuPosition = Offset(
                widgetPosition.dx + widgetSize.width, // 右侧
                widgetPosition.dy + widgetSize.height, // 下方
              );
              FeedPopupMenu.show(
                context: context,
                position: menuPosition,
                selected: _selected,
                width: widgetSize.width * 0.6,
                onSelected: (val) {
                  setState(() {
                    logger.i(val);
                    _selected = val;
                  });
                },
              );
            },
            child: Row(children: [
              SizedBox(width: 4,),
              Text(_selected, style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
              ),),
              SizedBox(width: 4,),
              SvgPicture.asset(Svgicons.chevronUpDown, width: 20, height: 20,),
            ],),
          ),
          SizedBox(width: 12,),
        ],
      ),
      if (_selected == "Custom")
        Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12),
          child: SpacerDivider(
            thickness: 0.5,
            spacing: 1,
            indent: 0,
            color: AppTheme.black8,
          ),
        ),
      if (_selected == "Custom")
        GestureDetector(
          onTap: (){},
          child: Row(children: [
            SizedBox(width: 20, height: 44,),
            Expanded(child: Text('Subscription Title, Subscription Title, Subscription Title,', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
            ),),),
            SizedBox(width: 8,),
            SvgPicture.asset(Svgicons.chevronRight, width: 20, height: 20,),
            SizedBox(width: 12,),
          ],),
        )
    ],);
  }



}



