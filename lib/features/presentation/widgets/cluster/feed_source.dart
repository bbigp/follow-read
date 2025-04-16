

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/presentation/widgets/cluster/select_feed.dart';
import 'package:follow_read/features/presentation/widgets/smart_modal.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';

import '../../../../config/svgicons.dart';
import '../../../../config/theme.dart';
import '../feed_popup_menu.dart';
import '../open_modal.dart';

class FeedSource extends StatefulWidget {

  final List<int> selected;

  const FeedSource({super.key,
    this.selected = const [],
  });

  @override
  State<StatefulWidget> createState() => _FeedSourceState();
}

class _FeedSourceState extends State<FeedSource> {


  Offset? cachedPosition;
  Size? cachedSize;
  void _cachePosition() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    cachedPosition = renderBox.localToGlobal(Offset.zero);
    cachedSize = renderBox.size;
  }

  bool _isSelected = false;
  List<int> _selected = [];

  @override
  void initState() {
    super.initState();
    _isSelected = widget.selected.isNotEmpty;
    _selected = widget.selected;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cachePosition(); // 页面绘制完毕后缓存一次
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 16, height: 44,),
          SvgPicture.asset(Svgicons.squareRss, width: 24, height: 24,),
          SizedBox(width: 12,),
          Expanded(child: Text('订阅源', style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
          ),)),
          GestureDetector(
            onTapDown: (details) {
              final Offset menuPosition = Offset(
                cachedPosition!.dx + cachedSize!.width,
                cachedPosition!.dy + cachedSize!.height,
              );
              FeedPopupMenu.show(
                context: context,
                position: menuPosition,
                selected: _isSelected ? 'Custom' : 'Off',
                options: ['Off', 'Custom'],
                onSelected: (val) {
                  setState(() {
                    _isSelected = 'Off' != val;
                  });
                },
              );
            },
            child: Row(children: [
              SizedBox(width: 4,),
              Text(_isSelected ? 'Custom' : 'Off', style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
              ),),
              SizedBox(width: 4,),
              SvgPicture.asset(Svgicons.chevronUpDown, width: 20, height: 20,),
            ],),
          ),
          SizedBox(width: 12,),
        ],
      ),
      if (_isSelected)
        Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12),
          child: SpacerDivider(
            thickness: 0.5,
            spacing: 1,
            indent: 0,
            color: AppTheme.black8,
          ),
        ),
      if (_isSelected)
        GestureDetector(
          onTap: (){
            OpenModal.open(context, SelectFeed(onSelect: (feed) {
              setState(() {
                _selected.add(feed.id);
              });
            },), scrollable: true);
          },
          child: Row(children: [
            SizedBox(width: 20, height: 44,),
            Expanded(child: Text(widget.selected.join(","), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
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




