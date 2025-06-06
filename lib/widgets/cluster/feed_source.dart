

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/pages/cluster_page.dart';
import 'package:follow_read/widgets/acx/spacer_divider.dart';
import 'package:follow_read/widgets/cluster/select_feed.dart';
import 'package:follow_read/widgets/feed_popup_menu.dart';

import '../../config/svgicons.dart';
import '../../config/theme.dart';
import '../open_modal.dart';

class FeedSource extends ConsumerStatefulWidget {

  const FeedSource({super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedSourceState();
}

class _FeedSourceState extends ConsumerState<FeedSource> {


  Offset? cachedPosition;
  Size? cachedSize;
  void _cachePosition() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    cachedPosition = renderBox.localToGlobal(Offset.zero);
    cachedSize = renderBox.size;
  }

  bool? _isSelected;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cachePosition(); // 页面绘制完毕后缓存一次
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedIds = ref.watch(clusterProvider.select((s) => s.feedIds));
    _isSelected ??= feedIds.isNotEmpty;
    return Column(children: [
      InkWell(onTap: (){
        final Offset menuPosition = Offset(
          cachedPosition!.dx + cachedSize!.width,
          cachedPosition!.dy + cachedSize!.height,
        );
        FeedPopupMenu.show(
          context: context,
          position: menuPosition,
          selected: _isSelected ?? false ? 'Custom' : 'Off',
          options: ['Off', 'Custom'],
          onSelected: (val) {
            setState(() {
              _isSelected = 'Off' != val;
            });
            if (!_isSelected!) {
              ref.read(clusterProvider.notifier).update(feedIds: []);
            }
          },
        );
      }, child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 16, height: 44,),
          SvgPicture.asset(Svgicons.squareRss, width: 24, height: 24,),
          const SizedBox(width: 12,),
          const Expanded(child: Text('订阅源', style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black95,
          ),)),
          const SizedBox(width: 4,),
          Text(_isSelected ?? false ? 'Custom' : 'Off', style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
          ),),
          const SizedBox(width: 4,),
          SvgPicture.asset(Svgicons.chevronUpDown, width: 20, height: 20,),
          const SizedBox(width: 12,),
        ],
      ),),
      if (_isSelected ?? false)
        const Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12),
          child: SpacerDivider(
            thickness: 0.5,
            spacing: 1,
            indent: 0,
            color: AppTheme.black8,
          ),
        ),
      if (_isSelected ?? false)
        GestureDetector(
          onTap: (){
            OpenModal.open(context, SelectFeed());
          },
          child: Row(children: [
            const SizedBox(width: 20, height: 44,),
            Expanded(child: Text(feedIds.join(","), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, height: 1.33, color: AppTheme.black50,
            ),),),
            const SizedBox(width: 8,),
            SvgPicture.asset(Svgicons.chevron_right, width: 20, height: 20,),
            const SizedBox(width: 12,),
          ],),
        )
    ],);
  }



}




