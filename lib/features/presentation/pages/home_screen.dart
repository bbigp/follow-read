import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/sync_task.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/home_page_provider.dart';
import 'package:follow_read/features/presentation/widgets/feed_item.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:follow_read/features/presentation/widgets/sync_view.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../../config/svgicons.dart';
import '../providers/sync_data_provider.dart';
import '../widgets/cluster_item.dart';
import '../widgets/home_group.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        //禁用自动返回箭头
        leading: IconButton(
            onPressed: () {
              ref.read(routerProvider).pushNamed(RouteNames.profile);
            },
            icon: const Icon(Icons.person)),
        actions: [
          InkWell(onTap: (){
            ref.read(routerProvider).pushNamed(RouteNames.addFeed);
          }, child: Svgicon(Svgicons.add, size: 24, iconSize: 20,),),
          const SizedBox(width: 16,),
          _buildRefreshButton(ref),
          const SizedBox(width: 12),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: SyncView(),
            ),
            SliverToBoxAdapter(
              child: HomeGroup(title: '智能视图', rightIcon: Svgicons.plusO, onTap: (){
                  ref.read(routerProvider).pushNamed(RouteNames.cluster,);
              },),
            ),
            if (!pageValue.isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final cluster = pageValue.value!.clusters[index];
                    return ClusterItem(
                      key: ValueKey(PageUtils.pid(TileType.cluster, cluster.id)),
                      cluster: cluster,
                    );
                  },
                  childCount: pageValue.value!.clusters.length,
                ),
              ),
            SliverToBoxAdapter(
              child: SpacerDivider(
                thickness: 0.2,
                spacing: 32,
                color: AppTheme.black8,
              ),
            ),
            SliverToBoxAdapter(
              child: HomeGroup(title: '订阅源', ),
            ),
            !pageValue.isLoading && pageValue.value!.tiles.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final tile = pageValue.value!.tiles[index];
                        return FeedItem(
                            key: ValueKey(PageUtils.pid(tile.type, tile.id)),
                            tile: tile);
                      },
                      childCount: pageValue.value!.tiles.length,
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Column(children: [
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39),
                        child: SvgPicture.asset(
                          Svgicons.folder,
                          height: 60,
                          width: 82,
                        ),
                      ),
                      // SizedBox(height: 8,),
                      Text(
                        '没有订阅源',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.33,
                          color: AppTheme.black25,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppTheme.black95,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // 关键属性
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Svgicons.plusWhite,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '添加订阅',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1.33,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefreshButton(WidgetRef ref) {
    final status = ref.watch(syncProvider.select((s) => s.status));
    return status == SyncTask.syncing
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            ),
          )
        : IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () async {
              ref.read(syncProvider.notifier).startSync();
            },
          );
  }
}
