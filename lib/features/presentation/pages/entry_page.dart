import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/features/presentation/providers/feed_detail_provider.dart';
import 'package:follow_read/features/presentation/widgets/entry_item.dart';
import 'package:follow_read/features/presentation/widgets/feed_header.dart';
import 'package:follow_read/features/presentation/widgets/feed_switch.dart';
import 'package:follow_read/features/presentation/widgets/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/no_more_loading.dart';
import 'package:follow_read/features/presentation/widgets/svg_icon.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/svg_icons.dart';
import '../../../config/theme.dart';
import '../../../core/utils/logger.dart';
import '../../domain/models/entry.dart';
import '../../domain/models/feed.dart';
import '../providers/entry_loading_provider.dart';

class EntryPage extends ConsumerStatefulWidget {
  final int feedId;

  const EntryPage({
    super.key,
    required this.feedId,
  });

  @override
  ConsumerState<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  // 添加订阅变量用于管理监听器
  ProviderSubscription<FeedDetailState>? _feedSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(feedDetailProvider(widget.feedId));
      ref.read(entriesLoadingProvider(widget.feedId).notifier)
          .fetchEntries(reset: true, onlyShowUnread: state.feed.onlyShowUnread);
    });
    _scrollController.addListener(_scrollListener);
  }


  @override
  Widget build(BuildContext context) {
    ref.listen<FeedDetailState>(feedDetailProvider(widget.feedId), (_, state){
      logger.i('${state.feed.onlyShowUnread}');
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        actions: [
          GestureDetector(
            onTap: () => _showFilterSheet(context),
            child: Padding(padding: EdgeInsets.only(right: 4), child: SvgIcon(SvgIcons.more),),
          ),
          // _buildRefreshButton(ref, feedsState.isSyncing),
          const SizedBox(width: 12),
        ],
      ),
      body: ref.watch(entriesLoadingProvider(widget.feedId).select((state) => state.isInitializing))
          ? _buildSmartSkeleton()
          : _buildListView(),
    );
  }


  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,   // 允许内容高度超过屏幕70%
      backgroundColor: AppTheme.white85,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Consumer(builder: (context, ref, _) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                // padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    // SizedBox(height: 16,),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), child: FeedSwitch(feedId: widget.feedId,),),
                    SizedBox(height: 21,)
                  ],
                ),
              );
            },
          );
        });
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

  void _scrollListener() {
    final state = ref.read(entriesLoadingProvider(widget.feedId));
    final position = _scrollController.position;

    // 空列表或未加载完成时直接返回
    if (position.maxScrollExtent <= 0) return;

    if (state.hasMore &&
        !state.isLoadingMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      ref.watch(entriesLoadingProvider(widget.feedId).notifier).fetchEntries();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();


  Widget _buildListView(){
    final state = ref.watch(entriesLoadingProvider(widget.feedId));
    final feed = ref.watch(feedDetailProvider(widget.feedId).select((state) => state.feed),);
    return RefreshIndicator(
        onRefresh: () async {
          ref.watch(entriesLoadingProvider(widget.feedId).notifier)
              .fetchEntries(reset: true);
        },
        child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.uiItems.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return FeedHeader(title: feed.title, unread: feed.unread,);
              }
              if (index - 1 >= state.uiItems.length) {
                if (state.isInitializing) {
                  return NoMoreLoading();
                }
                return state.hasMore ? LoadingMore() : NoMoreLoading();
              }
              return EntryItem(entry: state.uiItems[index - 1].content as Entry, feed: feed);
            }));
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