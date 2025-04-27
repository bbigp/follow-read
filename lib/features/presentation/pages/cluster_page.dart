

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/cluster.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';
import 'package:follow_read/features/presentation/widgets/cluster/advanced_view.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_button.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sliding_segmented_control.dart';
import 'package:follow_read/features/presentation/widgets/done_button.dart';

import '../../../config/icons.dart';
import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../widgets/cluster/basic_view.dart';
import '../widgets/two_tab_switch.dart';

final clusterProvider = NotifierProvider.autoDispose<ClusterNotifier, Cluster>(
  ClusterNotifier.new,
);

class ClusterNotifier extends AutoDisposeNotifier<Cluster> {

  late final _clusterRepository = ref.watch(clusterRepositoryProvider);
  @override
  Cluster build() => Cluster(icon: ClusterIcons.name(ClusterIcons.menu));

  void load(int id) async {
    final tile = await ref.read(tileProvider(PageUtils.pid(TileType.cluster, id)).future);
    state = tile.cluster;
  }

  void update({String? name, String? icon, int? recentTime, List<int>? feedIds,
    List<String>? statuses, int? recentAddTime,
  }) {
    state = state.copyWith(name: name, icon: icon, recentTime: recentTime,
      feedIds: feedIds, statuses: statuses,
      recentAddTime: recentAddTime,
    );
  }

  void save() {
    _clusterRepository.save(state);
  }

}


class ClusterPage extends ConsumerStatefulWidget {

  final int id;
  const ClusterPage({super.key, required this.id});

  @override
  ConsumerState<ClusterPage> createState() => _ClusterPageState();


}

class _ClusterPageState extends ConsumerState<ClusterPage> {


  String _selectedSegment = 'Basic';

  @override
  void initState() {
    super.initState();
    if (widget.id != 0) {
      ref.read(clusterProvider.notifier).load(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cluster = ref.watch(clusterProvider);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(54),
            child: Bar(title: 'New List', enabled: cluster.name.isNotEmpty,
              onPressed: () async {
                ref.read(clusterProvider.notifier).save();
                final _ = ref.refresh(homePageProvider);
                Navigator.pop(context);
              },
            )
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
                      const SizedBox(height: 4,),
                      CupxSlidingSegmentedControl(
                        groupValue: _selectedSegment,
                        onValueChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedSegment = value;
                            });
                          }
                        },
                        children: ['Basic', 'Advanced'],
                      ),
                      const SizedBox(height: 12,),
                      const SizedBox(height: 4,),
                      if (_selectedSegment == 'Basic') BasicView(),
                      if (_selectedSegment == 'Advanced') AdvancedView(),
                    ],),
                  ),
                );
              }
          ),
        )
    );
  }
}

class Bar extends StatelessWidget {
  final bool enabled;
  final String title;
  final Color color;
  final EdgeInsetsGeometry padding;
  final Future<void> Function()? onPressed;
  const Bar({super.key,
    required this.title,
    this.enabled = false,
    this.color = AppTheme.black4,
    this.padding = const EdgeInsets.only(left: 16, right: 16,),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Container(
          color: color,
          padding: padding,
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
              Expanded(child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  height: 1.29,
                  color: AppTheme.black95,
                ),)),
              CupxButton.text('Done',
                style: CupxButtonStyle.primary, size: Size(69, 36),
                enabled: enabled, onPressed: onPressed,
              ),
              // DoneButton(onPressed: onPressed, enabled: enabled, width: 69, height: 36, textStyle: TextStyle(
              //   fontSize: 15, fontWeight: FontWeight.w500, height: 1.33,
              // ), borderRadius: BorderRadius.circular(10),)
            ],
          ),
        ),
    );
  }

}

class CardView extends StatelessWidget {

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  const CardView({super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 4),
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
          border: Border.all(color: AppTheme.black4, width: 1),
        ),
        child: child
    );
  }
}
