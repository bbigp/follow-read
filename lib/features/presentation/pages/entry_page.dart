import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/presentation/providers/feed_detail_provider.dart';
import 'package:follow_read/features/presentation/widgets/entry_item.dart';
import 'package:follow_read/features/presentation/widgets/feed_header.dart';
import 'package:follow_read/features/presentation/widgets/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/no_more_loading.dart';
import 'package:follow_read/features/presentation/widgets/spacer_divider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/theme.dart';
import '../../../core/utils/logger.dart';
import '../../domain/models/entry.dart';
import '../providers/entry_loading_provider.dart';

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
      ref.watch(entriesLoadingProvider.notifier)
          .fetchEntries(feedId: widget.feedId, reset: true);
      // ref.watch(feedDetailProvider.notifier).fetchFeed(widget.feedId);
    });
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final state = ref.read(entriesLoadingProvider);
    final position = _scrollController.position;

    // 空列表或未加载完成时直接返回
    if (position.maxScrollExtent <= 0) return;

    if (state.hasMore &&
        !state.isLoadingMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      ref.watch(entriesLoadingProvider.notifier).fetchEntries();
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
    final unread = ref.watch(
      feedDetailProvider.select((state) => state.feed.unread),
    );
    final title = ref.watch(
      feedDetailProvider.select((state) => state.feed.title),
    );
    final feed = ref.watch(feedDetailProvider.select((state) => state.feed));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        actions: [
          GestureDetector(
            onTap: () {
              _showFilterSheet(context, feed);
            },
            child: Container(
              padding: EdgeInsets.only(right: 4),
              width: 28, height: 28,
              child: SvgPicture.asset(
                'assets/svg/more.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
          // _buildRefreshButton(ref, feedsState.isSyncing),
          const SizedBox(width: 12),
        ],
      ),
      body: state.isInitializing
          ? _buildSmartSkeleton()
          : RefreshIndicator(
              onRefresh: () async {
                ref.watch(entriesLoadingProvider.notifier)
                    .fetchEntries(feedId: widget.feedId, reset: true);
              },
              child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.uiItems.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return FeedHeader(title: title, unread: unread,);
                    }
                    if (index - 1 >= state.uiItems.length) {
                      if (state.isInitializing) {
                        return NoMoreLoading();
                      }
                      return state.hasMore ? LoadingMore() : NoMoreLoading();
                    }
                    return EntryItem(entry: state.uiItems[index - 1].content as Entry);
                  })),
    );
  }


  void _showFilterSheet(BuildContext context, Feed feed) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,   // 允许内容高度超过屏幕70%
      backgroundColor: AppTheme.white85,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 顶部拖拽指示条
                  _buildDragHandle(),
                  // 视图类型选项卡
                  // _buildViewTypeTabs(setState),
                  // 排序选项
                  // _buildSortOptions(setState),  RadioListTile
                  // 附加选项
                  _buildAdditionalOptions(),
                ],
              ),
            );
          },
        );
      },
    );
  }
  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 36,
        height: 3.5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.black8,
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }


  Widget _buildAdditionalOptions() {
    final onlyUnread = ref.watch(
      feedDetailProvider.select((state) => state.onlyUnread),
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(width: 24, height: 28, child: SvgPicture.asset(
                  'assets/svg/eyes.svg',
                  height: 24, width: 24,
                ),),
                Expanded(child: Padding(padding: EdgeInsets.only(left: 12, right: 12), child: Text(
                  '只显示未读', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                  color: AppTheme.black95,
                ),),)),
                SizedBox(
                    height: 28, width: 48,
                    child: Transform.scale(
                      scale: 0.8, // 缩放比例 (0.8 对应默认尺寸的 80%)
                      child: Switch(
                        value: onlyUnread,
                        padding: EdgeInsets.all(0),
                        thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
                          return Icon(Icons.circle, size: 20,
                            color: Colors.white,
                          );
                        }),
                        activeColor: Colors.white,      // 开启状态滑块颜色
                        activeTrackColor: AppTheme.black95, // 开启轨道颜色
                        inactiveThumbColor: Colors.white, // 关闭状态滑块颜色
                        inactiveTrackColor: AppTheme.black8, // 关闭轨道颜色
                        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent), // 移除边框
                        trackOutlineWidth: const WidgetStatePropertyAll(0.0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 调整点击区域
                        onChanged: (v) async {
                          logger.i('$v');
                          await ref.read(feedDetailProvider.notifier).updateFeed(v);
                        },
                      ),
                    )
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 20, left: 52),
            child: SpacerDivider(
              thickness: 0.5,
              spacing: 1,
              indent: 0,
              color: AppTheme.black8,
            ),
          ),
          Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(width: 24, height: 28, child: SvgPicture.asset(
                  'assets/svg/time.svg',
                  height: 24, width: 24,
                ),),
                Expanded(child: Padding(padding: EdgeInsets.only(left: 12, right: 12), child: Text(
                  '阅读时间', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                  color: AppTheme.black95,
                ),),)),
                SizedBox(
                  height: 28, width: 48,
                  child: Transform.scale(
                    scale: 0.8, // 缩放比例 (0.8 对应默认尺寸的 80%)
                    child: Switch(
                      value: false,
                      padding: EdgeInsets.all(0),
                      thumbIcon: WidgetStateProperty.resolveWith<Icon>((states) {
                        return Icon(Icons.circle, size: 20,
                          color: Colors.white,
                        );
                      }),
                      activeColor: Colors.white,      // 开启状态滑块颜色
                      activeTrackColor: AppTheme.black95, // 开启轨道颜色
                      inactiveThumbColor: Colors.white, // 关闭状态滑块颜色
                      inactiveTrackColor: AppTheme.black8, // 关闭轨道颜色
                      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent), // 移除边框
                      trackOutlineWidth: const WidgetStatePropertyAll(0.0),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 调整点击区域
                      onChanged: (v) => setState(() {

                      }),
                    ),
                  )
                ),
              ],
            ),
          ),




          // SwitchListTile(
          //   title: const Text('Group by Publication Date'),
          //   value: _groupByDate,
          //   onChanged: (value){
          //
          //   },
          // ),
          // SwitchListTile(
          //   title: const Text('Reading Duration'),
          //   value: _showDuration,
          //   onChanged: (value) {
          //
          //   },
          // ),
        ],
      ),
    );
  }



  Widget _buildSmartSkeleton() {
    return Shimmer.fromColors(
      baseColor: AppTheme.black4,
      highlightColor: AppTheme.black8,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 11,
        itemBuilder: (context, index) => index == 0
            ? SkeletonFeedHeader() // 第一个项用于测量
            : SkeletonEntryItem(), // 后续项复用
      ),
    );
  }


  Widget _noContentYet() {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight / 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24, left: 35, right: 35, bottom: 0),
              child: Image.asset(
                'assets/png/no_content_yet.png',
                width: 90,
                height: 46,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                '没有内容了',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.33,
                  color: AppTheme.black25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}