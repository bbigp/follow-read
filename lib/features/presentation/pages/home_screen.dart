import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/domain/models/sync_task.dart';
import 'package:follow_read/features/presentation/providers/feed_loading_provider.dart';
import 'package:follow_read/features/presentation/widgets/feed_item.dart';
import 'package:follow_read/features/presentation/widgets/list_item.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/sync_view.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../../config/svgicons.dart';
import '../../domain/models/feed.dart';
import '../../domain/models/listx.dart';
import '../providers/sync_data_provider.dart';
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
    // 页面初始化时触发数据加载
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedLoadingProvider.notifier).getFeeds();
    });
    _scrollController.addListener(_scrollListener);

  }
  final ScrollController _scrollController = ScrollController();
  Future<void> _refreshData() async {
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final feedsState = ref.watch(feedLoadingProvider);
    final syncState = ref.watch(syncProvider);
    if (syncState.status == SyncTask.success && syncState.refreshUi) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(feedLoadingProvider.notifier).getFeeds();
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
            _buildRefreshButton(ref),
            const SizedBox(width: 12),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: SyncView(),),
              SliverToBoxAdapter(
                child: HomeGroup(title: '智能视图'),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  ListItem(list: Listx(title: '全部', unread: 90, svgicon: Svgicons.all)),
                  ListItem(list: Listx(title: '近期已读', svgicon: Svgicons.markRead)),
                  ListItem(list: Listx(title: '星标', svgicon: Svgicons.addCollection)),
                  ListItem(list: Listx(title: '未读', svgicon: Svgicons.markUnread)),
                  ListItem(list: Listx(title: '今日', svgicon: Svgicons.today)),
                ]),
              ),
              // 分隔线
              SliverToBoxAdapter(
                child: SpacerDivider(
                  thickness: 0.2,
                  spacing: 32,
                  color: AppTheme.black8,
                ),
              ),
              // 订阅源标题
              SliverToBoxAdapter(
                child: HomeGroup(title: '订阅源'),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final feed = feedsState.items[index].content as Feed;
                    return FeedItem(key: ValueKey(feed.id), feed: feed);
                  },
                  childCount: feedsState.items.length,
                ),
              )
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

