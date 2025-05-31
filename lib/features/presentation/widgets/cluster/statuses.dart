


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/features/presentation/pages/cluster_page.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';

import '../../../../config/svgicons.dart';
import '../../../../config/theme.dart';
import '../feed_popup_menu.dart';
import '../open_modal.dart';
import 'filter_view.dart';
import 'select_status.dart';

class Statuses extends ConsumerStatefulWidget {

  const Statuses({super.key,});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatusesState();
}

class _StatusesState extends ConsumerState<Statuses> {


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
    final statuses = ref.watch(clusterProvider.select((s) => s.statuses));
    _isSelected ??= statuses.isNotEmpty;
    return Column(children: [
      FilterView(name: '已读未读', icon: Svgicons.onlyUnread, isSelected: _isSelected ?? false,
          onTap: (){
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
                  ref.read(clusterProvider.notifier).update(statuses: []);
                }
                if (_isSelected!) {
                  OpenModal.open(context, SelectStatus(), scrollable: false);
                }
              },
            );
          },
      ),
      if (statuses.isNotEmpty)
        const Padding(padding: EdgeInsets.only(right: 12, left: 16 + 24 + 12),
          child: SpacerDivider(
            thickness: 0.5,
            spacing: 1,
            indent: 0,
            color: AppTheme.black8,
          ),
        ),
      if (statuses.isNotEmpty)
        GestureDetector(
          onTap: (){
            OpenModal.open(context, SelectStatus(), scrollable: false);
          },
          child: Row(children: [
            const SizedBox(width: 20, height: 44,),
            Expanded(child: Text(statuses.join(","), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(
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




