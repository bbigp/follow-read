

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/aist.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/home_provider.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';
import 'package:follow_read/features/presentation/widgets/cluster/advanced_view.dart';
import 'package:follow_read/features/presentation/widgets/components/buttonx.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sheet_title.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_sliding_segmented_control.dart';

import '../../../config/cluster_icons.dart';
import '../../../config/theme.dart';
import '../widgets/cluster/basic_view.dart';

final clusterProvider = NotifierProvider.autoDispose<ClusterNotifier, Cluster>(
  ClusterNotifier.new,
);

class ClusterNotifier extends AutoDisposeNotifier<Cluster> {

  late final _clusterRepository = ref.watch(clusterRepositoryProvider);
  @override
  Cluster build() => Cluster(icon: ClusterIcons.reverseIconsMap[ClusterIcons.list_bullet]!);

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
            child: CenteredSheetTitle(
              // context,
              // color: AppTheme.black4, height: 54,
              title: 'New List',
              // leading: CupxSheetTitleCloseButton(),
              // button: TextButtonx(child: 'Done',
              //   size: Sizex.smallCompact,
              //   type: ButtonxType.primary,
              //   enabled: cluster.name.isNotEmpty,
              //   onPressed: () async {
              //     ref.read(clusterProvider.notifier).save();
              //     final _ = ref.refresh(homeProvider);
              //     Navigator.pop(context);
              //   },
              // ),
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

