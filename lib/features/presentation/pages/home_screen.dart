import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/providers/feed_loading_provider.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:follow_read/routes/app_route.dart';

import '../../domain/models/feed.dart';
import '../widgets/feed_icon.dart';

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
            itemCount: feedsState.feeds.length,
            itemBuilder: (context, index) {
              return _buildFeedItem(feedsState.feeds[index]);
            }));
  }

  Widget _buildFeedItem(Feed feed) {
    if (feed.viewType == ViewType.feedItem) {
      return Column(
        children: [
          SizedBox(
            height: 52,
            child: ListTile(
              dense: true,
              horizontalTitleGap: 12,
              // 图标与标题的水平间距（默认16）
              onTap: () {
                ref.read(routerProvider).pushNamed(
                    RouteNames.entry,
                    pathParameters: {'feedId': feed.id.toString()}
                );
              },
              leading: FeedIcon(
                title: feed.title,
                iconUrl: "",
              ),
              title: Text(feed.title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    color: Color(0xF2000000),
                  )),
              trailing: Text(
                '${feed.unread > 0 ? feed.unread : ''}',
                // 这里可以是你想显示的任何数字
                style: const TextStyle(
                  color: Color(0x40000000),
                  fontSize: 13,
                  height: 1.38,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SpacerDivider(
            spacing: 1,
            thickness: 0.5,
          ),
        ],
      );
    } else if (feed.viewType == ViewType.groupTitleItem) {
      return Container(
        height: 40,
        // color: Colors.blue,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            feed.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 1.29,
              color: const Color(0xF2000000),
            ),
          ),
        ),
      );
    } else if (feed.viewType == ViewType.listItem) {
      return Column(
        children: [
          SizedBox(
            height: 44,
            child: ListTile(
              dense: true,
              horizontalTitleGap: 12,
              // 图标与标题的水平间距（默认16）
              onTap: () {},
              leading: Icon(feed.iconData),
              title: Text(feed.title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    color: Color(0xF2000000),
                  )),
              trailing: Text(
                '${feed.unread > 0 ? feed.unread : ''}',
                // 这里可以是你想显示的任何数字
                style: const TextStyle(
                  color: Color(0x40000000),
                  fontSize: 13,
                  height: 1.38,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (feed.viewType == ViewType.divider32) {
      // return Container(height: 32,);
      return SpacerDivider(
        thickness: 0.2,
        spacing: 32,
        color: const Color(0x14000000),
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
