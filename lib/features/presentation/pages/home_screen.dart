import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/providers/feed_loading_provider.dart';
import 'package:follow_read/features/presentation/widgets/feed_item.dart';
import 'package:follow_read/features/presentation/widgets/list_item.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../domain/models/feed.dart';
import '../../domain/models/listx.dart';
import '../../domain/models/ui_item.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final feedsState = ref.watch(feedLoadingProvider);
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
            _buildRefreshButton(ref, feedsState.isSyncing),
            const SizedBox(width: 12),
          ],
        ),
        body: ListView.builder(
            itemCount: feedsState.items.length,
            itemBuilder: (context, index) {
              return _buildFeedItem(feedsState.items[index]);
            })
    );
  }

  Widget _buildFeedItem(UiItem item) {
    if (item.type == ViewType.feedItem) {
      return FeedItem(feed: item.content as Feed);
    } else if (item.type == ViewType.groupTitleItem) {
      final title = item.content as TitleUiData;
      return Container(
        height: 40,
        // color: Colors.blue,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 1.29,
              color: AppTheme.black95,
            ),
          ),
        ),
      );
    } else if (item.type == ViewType.listItem) {
      return ListItem(list: item.content as Listx,);
    } else if (item.type == ViewType.divider32) {
      return SpacerDivider(
        thickness: 0.2,
        spacing: 32,
        color: AppTheme.black8,
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _buildRefreshButton(WidgetRef ref, bool isLoading) {
    return isLoading
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
              await ref.watch(feedLoadingProvider.notifier).refresh();
            },
          );
  }
}



// // 在页面A的 State 类中添加
// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();
//
//   // 监听路由变化
//   final route = ModalRoute.of(context);
//   if (route != null) {
//     routeObserver.subscribe(this, route);
//   }
// }
//
// @override
// void didPopNext() {
//   // 当从其他页面返回时验证数据
//   ref.invalidate(itemListProvider); // 可选：强制刷新数据
// }