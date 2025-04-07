import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';
import 'package:follow_read/features/presentation/widgets/entry_item.dart';
import 'package:follow_read/features/presentation/widgets/feed_header.dart';
import 'package:follow_read/features/presentation/widgets/feed_switch.dart';
import 'package:follow_read/features/presentation/widgets/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/no_more_loading.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../domain/models/tile.dart';
import '../providers/entry_page_provider.dart';
import '../widgets/spacer_divider.dart';

class EntryPage extends ConsumerStatefulWidget {
  final int id;
  final bool onlyShowUnread;
  final TileType type;

  const EntryPage({
    super.key,
    required this.id,
    required this.onlyShowUnread,
    required this.type,
  });

  @override
  ConsumerState<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  bool? _lastUsedUnreadFlag;
  final ScrollController _scrollController = ScrollController();

  String get pid => PageUtils.pid(widget.type, widget.id);

  @override
  void initState() {
    super.initState();
    if (_lastUsedUnreadFlag == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _lastUsedUnreadFlag = widget.onlyShowUnread;
        ref.watch(entriesProvier(pid).notifier).fetchEntries(reset: true, onlyShowUnread: widget.onlyShowUnread);
        ref.watch(tileProvider(pid).notifier).loadData();
      });
    }
    ref.listenManual(tileProvider(pid), (_, current){
      final currentUnread = current.value?.onlyShowUnread;
      if (_lastUsedUnreadFlag != null && currentUnread != null && _lastUsedUnreadFlag != currentUnread) {
        _lastUsedUnreadFlag = currentUnread;
        ref.watch(entriesProvier(pid).notifier).fetchEntries(reset: true, onlyShowUnread: currentUnread);
      }
    });
    _scrollController.addListener(_scrollListener);
  }


  @override
  Widget build(BuildContext context) {
    final tileState = ref.watch(entryPageProvider(pid).select((s) => s.tileState));
    final isInitializing = ref.watch(entryPageProvider(pid).select((s) => s.entriesState.value.isInitializing));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        actions: [
          GestureDetector(
            onTap: () => _showFilterSheet(context),
            child: Padding(
              padding: EdgeInsets.only(right: 4),
              child: Svgicon(Svgicons.more),
            ),
          ),
          // _buildRefreshButton(ref, feedsState.isSyncing),
          const SizedBox(width: 12),
        ],
      ),
      body: tileState.isLoading || isInitializing
          ? _buildSmartSkeleton()
          : _buildListView(),
      // body: feedAsync.when(
      //   data: (feed) {
      //     return entriesAsync.when(
      //         data: (state) => state.isInitializing ? _buildSmartSkeleton() : _buildListView(feed),
      //         error: (error, stack) => _noContentYet(),
      //         loading: () => const SizedBox.shrink(),
      //     );
      //   },
      //   error: (error, stack) => _noContentYet(),
      //   loading: () => _buildSmartSkeleton(),
      // ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // 允许内容高度超过屏幕70%
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: FeedSwitch(id: widget.id, type: widget.type,),
                    ),
                    SizedBox(
                      height: 21,
                    )
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
    final state = ref.read(entriesProvier(pid).select((s) => s.value));
    final position = _scrollController.position;

    // 空列表或未加载完成时直接返回
    if (position.maxScrollExtent <= 0) return;

    if (state.hasMore && !state.isLoadingMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      ref.read(entriesProvier(pid).notifier)
          .fetchEntries(onlyShowUnread: _lastUsedUnreadFlag ?? widget.onlyShowUnread);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }


  Widget _buildListView() {
    final pageValue = ref.watch(entryPageProvider(pid));
    final entriesState = pageValue.entriesState.value;
    final tile = pageValue.tileState.value!;
    return RefreshIndicator(
        onRefresh: () async {
          ref.watch(entriesProvier(pid).notifier).fetchEntries(reset: true, onlyShowUnread: widget.onlyShowUnread);
          ref.watch(tileProvider(pid).notifier).loadData();
        },
        child: ListView.separated(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: entriesState.entries.length + 2,
            separatorBuilder: (_, index) => index == 0
                ? const SizedBox.shrink()
                : SpacerDivider(indent: 16, spacing: 1, thickness: 0.5,),
            itemBuilder: (context, index) {
              if (index == 0) {
                return FeedHeader(
                  title: tile.title,
                  unread: tile.unread,
                );
              }
              if (index - 1 >= entriesState.entries.length) {
                if (entriesState.isInitializing) {
                  return NoMoreLoading();
                }
                return entriesState.hasMore ? LoadingMore() : NoMoreLoading();
              }
              final entry = entriesState.entries[index - 1];
              return entry.isUnread
                  ? EntryItem(entry: entry, tile: tile)
                  : Opacity(opacity: 0.5,
                      child: EntryItem(entry: entry, tile: tile),
                    );
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
