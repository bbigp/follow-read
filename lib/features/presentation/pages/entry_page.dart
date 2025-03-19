
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/presentation/widgets/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/no_more_loading.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/theme.dart';
import '../../domain/models/ui_item.dart';
import '../../domain/models/entry.dart';
import '../providers/entry_loading_proviider.dart';
import '../widgets/dashed_line.dart';
import '../widgets/spacer_divider.dart';

class EntryPage extends ConsumerStatefulWidget {
  final int feedId;

  const EntryPage({
    required this.feedId,
    super.key,
  });

  @override
  ConsumerState<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(entriesLoadingProvider.notifier).fetchEntry(feedId: widget.feedId, reset: true);
    });
    _scrollController.addListener(_scrollListener);
  }


  void _scrollListener() {
    final state = ref.read(entriesLoadingProvider);
    final position = _scrollController.position;

    // 空列表或未加载完成时直接返回
    if (position.maxScrollExtent <= 0) return;

    if (state.hasMore &&
        !state.isLoadingMore && _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.watch(entriesLoadingProvider.notifier).fetchEntry();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(entriesLoadingProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          actions: [
            // _buildRefreshButton(ref, feedsState.isSyncing),
            // const SizedBox(width: 12),
          ],
        ),
        body: state.isInitializing ? _buildSmartSkeleton () : RefreshIndicator(child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.uiItems.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.uiItems.length) {
                if (state.isInitializing) {
                  return NoMoreLoading();
                }
                return state.hasMore ? LoadingMore() : NoMoreLoading();
              }
              return _buildItem(state.uiItems[index]);
            }), onRefresh: () async {
          ref.watch(entriesLoadingProvider.notifier).fetchEntry(feedId: widget.feedId, reset: true);
        }),
    );
  }

  double? _skeletonItemHeight; // 存储测量后的骨架项高度

  final GlobalKey _skeletonItemKey = GlobalKey(); // 用于测量骨架项高度

  int _calculateItemCount(double maxHeight) {
    if (_skeletonItemHeight == null || _skeletonItemHeight! <= 0) {
      return 10; // 默认显示10项直到完成测量
    }
    // 计算项数公式：屏幕高度/单项高度 + 2个缓冲项
    return (maxHeight / _skeletonItemHeight!).ceil() + 2;
  }

  Widget _buildSmartSkeleton(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 首次测量骨架项高度
          if (_skeletonItemHeight == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final renderBox = _skeletonItemKey.currentContext?.findRenderObject() as RenderBox?;
              if (renderBox != null && mounted) {
                setState(() {
                  _skeletonItemHeight = renderBox.size.height;
                });
              }
            });
          }

          // 动态计算项数
          final itemCount = _calculateItemCount(constraints.maxHeight);

          logger.i('计算count: ${itemCount}');

          var title = 'The best last-minute Cyber Monday you can still shop';
          var desc = 'There’s still some time to save on a wide range of Verge-approved goods, including streaming services, iPads, and ebook readers.';
          var url = 'https://i1.hdslb.com/bfs/article/26c34746fceeeea24c72fdba06fe006757276677.png@1192w.avif';
          var url2 = 'https://i1.hdslb.com/bfs/article/b5a29a9b8ad1aba8b45e64fa505e410357276677.png@1192w.avif';

          final e2 = Entry(id: 2, hash: '2', title: title, description: desc, readingTime: 5, pic: url2, showReadingTime: true);
          final u = UiItem(type: ViewType.entryItem, content: e2);

          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) => index == 0
                ? _buildMeasurableSkeletonItem(u) // 第一个项用于测量
                : _buildItem(u),          // 后续项复用
          );
        },
      ),
    );
  }

  Widget _buildMeasurableSkeletonItem(UiItem u) {

    return SizedBox(
      key: _skeletonItemKey,
      child: _buildItem(u),
    );
  }

  Widget _buildItem(UiItem uiItem) {
    if (uiItem.type == ViewType.entryItem) {
      return _buildEntryItem(uiItem);
    }
    if (uiItem.type == ViewType.feedHeaderItem) {
      return _buildFeedHeader(uiItem);
    }
    if (uiItem.type == ViewType.noContentYetItem) {
      return _noContentYet();
    }
    return Text('dsds');
  }

  Widget _buildFeedHeader(UiItem uiItem){
    final feed = uiItem.content as FeedHeader;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        height: 1.21,
                        color: AppTheme.black95,
                      ),
                    )
                  ],
                ),
                if (feed.subTitle.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          '99+ 未读',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            height: 1.18,
                            color: AppTheme.black25,
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),),
          DashedDivider(
            indent: 0,
            spacing: 16,
            thickness: 1,
            color: AppTheme.black8,
          ),
        ],
      ),
    );
  }


  Widget _noContentYet() {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight / 5),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.only(top: 24, left: 35, right: 35, bottom: 0),
              child: Image.asset(
                'assets/png/no_content_yet.png',
                width: 90,
                height: 46,
              ),),
            Padding(padding: EdgeInsets.only(top: 8),
              child: Text('没有内容了', style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.33,
                color: AppTheme.black25,
              ),),)
          ],
        ),
      ),
    );


  }

  Widget _buildEntryItem(UiItem uiItem) {
    final entry = uiItem.content as Entry;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 18,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: CachedNetworkImage(
                        imageUrl: entry.feed.feedUrl,
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 18,
                            height: 18,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 18,
                          height: 18,
                          color: Colors.grey[300], // 错误时的背景颜色
                          child: Icon(Icons.error, color: Colors.red, size: 10,), // 错误图标
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          entry.feed.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.38,
                            color: AppTheme.black95,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                      child: Text(
                        entry.publishedAt.toShowTime(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.38,
                          color: AppTheme.black25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 4,
                            ),
                            child: Text(
                              entry.title,
                              maxLines: entry.tilteLines,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 1.33,
                                color: AppTheme.black95,
                              ),
                            ),
                          ),
                          if (entry.showReadingTime)
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: SizedBox(
                                height: 18,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: AppTheme.black50,
                                      ),
                                    ),
                                    Text(
                                      '${entry.readingTime}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        height: 1.38,
                                        color: AppTheme.black50,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          if (entry.description != "")
                            Text(
                              entry.description,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                height: 1.38,
                                color: AppTheme.black50,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (entry.pic != "")
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: entry.pic,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300], // 错误时的背景颜色
                              child:
                                  Icon(Icons.error, color: Colors.red), // 错误图标
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SpacerDivider(
          indent: 16,
          spacing: 1,
          thickness: 0.5,
        ),
      ],
    );
  }
}
