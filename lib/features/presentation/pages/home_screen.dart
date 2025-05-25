import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/sync_task.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/sync_data_provider.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_app_bar.dart';
import 'package:follow_read/features/presentation/widgets/components/dashed_line.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/features/presentation/widgets/components/sync_icon.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';
import 'package:follow_read/features/presentation/widgets/feed/feed_creator.dart';
import 'package:follow_read/features/presentation/widgets/home/cluster_tile.dart';
import 'package:follow_read/features/presentation/widgets/home/feed_stream.dart';
import 'package:follow_read/features/presentation/widgets/home/group_tile.dart';
import 'package:follow_read/features/presentation/widgets/home/loading_page.dart';
import 'package:follow_read/features/presentation/widgets/open_modal.dart';
import 'package:follow_read/features/presentation/widgets/sync_view.dart';
import 'package:follow_read/routes/app_route.dart';

///
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus(); // 收起键盘
    });
  }

  final ScrollController _scrollController = ScrollController();

  Future<void> _refreshData() async {}

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {}
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final syncState = ref.watch(syncProvider);
    final pageValue = ref.watch(homePageProvider);
    if (syncState.status == SyncTask.success && syncState.refreshUi) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final _ = ref.refresh(homePageProvider);
        ref.read(syncProvider.notifier).resetStatus();
      });
    }

    if (pageValue.isLoading) {
      return const LoadingPage();
    }
    final homeList = pageValue.requireValue;
    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(Svgicons.user_fill, onTap: (){
          ref.read(routerProvider).pushNamed(RouteNames.profile);
        },),
        actions: [
          PaddedSvgIcon(Svgicons.add, onTap: (){
            OpenModal.open(context, FeedCreator(), scrollable: false);
          },),
          SyncIcon(),
          PaddedSvgIcon(Svgicons.more,),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(child: SyncView(),),
            SliverToBoxAdapter(
              child: GroupTile(title: '智能视图', trailing: AddTrailing(onTap: () {
                ref.read(routerProvider).pushNamed(RouteNames.cluster,);
              })),
            ),
            SliverList(delegate: SliverChildBuilderDelegate(
              childCount: homeList.clusters.length,
              (context, index) {
                final cluster = homeList.clusters[index];
                return ClusterTile(
                  key: ValueKey(PageUtils.pid(TileType.cluster, cluster.id)),
                  cluster: cluster,
                );
              },
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
                child: DashedDivider(indent: 0, thickness: 0.5, spacing: 0,
                  color: AppTheme.black8,
                ),
              ),
            ),
            SliverToBoxAdapter(child: GroupTile(title: '订阅源',)),
            FeedStream(),
          ],
        ),
      ),
    );
  }
}
