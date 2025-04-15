

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';
import 'package:follow_read/features/presentation/widgets/done_button.dart';
import 'package:follow_read/features/presentation/widgets/input_field.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';

import '../../../config/icons.dart';
import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../widgets/list_switch.dart';
import '../widgets/two_tab_switch.dart';

class ClusterPage extends ConsumerStatefulWidget {

  final int id;
  const ClusterPage({super.key, required this.id});

  @override
  ConsumerState<ClusterPage> createState() => _ClusterPageState();


}

class _ClusterPageState extends ConsumerState<ClusterPage> {


  List<String> icons = ClusterIcons.iconsPaths;
  String _selectedSegment = 'Basic';
  String _name = "";
  bool _enabled = false;
  String _icon = "";
  bool _inited = false;//第一次的时候初始化数据
  List<int> _feedIds = [];
  String _recentTime = 'Off';

  void initView(Cluster cluster){
    if (_inited) return;
    _inited = true;
    _icon = cluster.svgIcon;
    _name = cluster.name;
    _enabled = true;
    _feedIds = cluster.feedIds;
    _recentTime = switch(cluster.recentTime) {
      1440 => '最近24小时',
      2880 => '最近48小时',
      10080 => '最近一周',
      40320 => '最近一个月',
      _ => 'Off'
    };
  }

  @override
  Widget build(BuildContext context) {
    var cluster = Cluster(icon: ClusterIcons.name(ClusterIcons.menu));
    if (widget.id != 0) {
      final tileAsync = ref.watch(tileProvider(PageUtils.pid(TileType.cluster, widget.id)));
      if (tileAsync.isLoading) return SizedBox.shrink();
      cluster = tileAsync.requireValue.cluster;
    }
    initView(cluster);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: SafeArea(
          bottom: false,
          child: Container(
            color: AppTheme.black4,
            padding: EdgeInsets.only(left: 16, right: 16,),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 30, height: 30,
                    margin: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.black4,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(Svgicons.x, width: 20, height: 20,),
                  ),
                ),
                SizedBox(width: 39,),
                Expanded(child: Text('New List',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  height: 1.29,
                  color: AppTheme.black95,
                ),)),
                DoneButton(onPressed: (){

                }, enabled: _enabled, width: 69, height: 36, textStyle: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, height: 1.33,
                ), borderRadius: BorderRadius.circular(10),)
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: AppTheme.black4,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                child: Column(children: [
                  SizedBox(height: 4,),
                  TwoTabSwitch(leftLabel: 'Basic', leftValue: 'Basic',
                    rightLabel: 'Advanced', rightValue: 'Advanced',
                    selectedValue: _selectedSegment,
                    onChanged: (v) {
                        setState(() {
                          _selectedSegment = v;
                        });
                    },
                    borderRadius: 10, selectedBorderRadius: 8, height: 36,
                  ),
                  SizedBox(height: 12,),
                  SizedBox(height: 4,),
                  if (_selectedSegment == 'Basic') _leftView(),
                  if (_selectedSegment == 'Advanced') _rightView(),

                ],),
              ),
            );
          }
        ),
      )
    );
  }

  Widget _rightView(){
    return Column(children: [
      if (_feedIds.isNotEmpty) CardView(child: FeedSource(icon: Svgicons.squareRss, title: '订阅源', selected: _feedIds,),),
      if (_recentTime != 'Off')
        CardView(child: FeedSource(icon: Svgicons.calendarToday,
          title: '发布日期',
          isMultiSelect: false,
          selected: [_recentTime],
          options: ['Off', '最近24小时', '最近48小时', '最近一周', '最近一个月'],
        ),),

      Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: AppTheme.black4, width: 1),
        ),
        child: Column(children: [
          if (_feedIds.isEmpty) FeedSource(icon: Svgicons.squareRss, title: '订阅源',),
          if (_recentTime == 'Off') FeedSource(icon: Svgicons.calendarToday, title: '发布日期',),
        ],)
      ),
    ],);
  }


  Widget _leftView(){
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: AppTheme.white0,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(12),
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.white0,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: AppTheme.black8),
            ),
            child: Svgicon(_icon, size: 40, iconSize: 24, fit: BoxFit.none),
          ),
          SizedBox(width: 12,),
          Expanded(child: InputField(onChanged: (v) {
            setState(() {
              _enabled = v != "";
              _name = v;
            });

          }, hintText: '标题', data: _name,
            contentPadding: EdgeInsets.only(left: 12, top: 10, bottom: 10),
            suffixIconPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ))
        ],),
      ),
      SizedBox(height: 16,),
      Container(
        decoration: BoxDecoration(
          color: AppTheme.white0,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 12),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // 如果你希望外部控制滚动
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemCount: icons.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 40, // 每个图标最大宽度（可根据需求调整）
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final icon = icons[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _icon = icon;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: icon == _icon ? AppTheme.black8 : Colors.transparent,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Svgicon(icon, size: 40, iconSize: 24, fit: BoxFit.none,),
              ),
            );
          },
        ),
      )
    ],);
  }

}

class CardView extends StatelessWidget {

  final Widget child;
  final double borderRadius;
  const CardView({super.key,
    required this.child,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
          border: Border.all(color: AppTheme.black4, width: 1),
        ),
        child: child
    );
  }
}
