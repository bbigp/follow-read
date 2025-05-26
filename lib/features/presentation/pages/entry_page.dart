
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';
import 'package:follow_read/features/presentation/widgets/components/alert_banner.dart';
import 'package:follow_read/features/presentation/widgets/feed/feed_settings_sheet.dart';
import 'package:follow_read/features/presentation/widgets/entry_item.dart';
import 'package:follow_read/features/presentation/widgets/feed_header.dart';
import 'package:follow_read/features/presentation/widgets/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/no_more_loading.dart';
import 'package:follow_read/features/presentation/widgets/open_modal.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/svgicons.dart';
import '../../../config/theme.dart';
import '../../../routes/app_route.dart';
import '../../domain/models/tile.dart';
import '../providers/entry_page_provider.dart';
import '../widgets/entry/skeleton_entry_item.dart';
import '../widgets/components/spacer_divider.dart';

class EntryPage extends ConsumerStatefulWidget {
  final int id;
  final TileType type;

  const EntryPage({
    super.key,
    required this.id,
    required this.type,
  });

  @override
  ConsumerState<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  final ScrollController _scrollController = ScrollController();

  String get pid => PageUtils.pid(widget.type, widget.id);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }


  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(entriesProvier(pid));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        surfaceTintColor: Colors.white, // 防止 Material 3 的默认着色影响
        actions: [
          SizedBox(width: 16,),
          GestureDetector(
            onTap: () => ref.read(routerProvider).pushNamed(RouteNames.search, pathParameters: {
              'id': widget.id.toString(),
              'type': widget.type.toString(),
            }),
            child: Svgicon(Svgicons.search, size: 28, iconSize: 24,),
          ),
          SizedBox(width: 16,),
          GestureDetector(
            onTap: () => OpenModal.open(context,
                FeedSettingsSheet(id: widget.id, type: widget.type,),
                scrollable: true
            ),
            child: Svgicon(Svgicons.more, size: 28, iconSize: 24,)
          ),
          // _buildRefreshButton(ref, feedsState.isSyncing),
          const SizedBox(width: 16),
        ],
      ),
      body: entriesAsync.isLoading
          ? _buildSmartSkeleton()
          : _buildMain(),
    );
  }



  void _scrollListener() {
    final entriesAsync = ref.watch(entriesProvier(pid));
    final position = _scrollController.position;

    // 空列表或未加载完成时直接返回
    if (position.maxScrollExtent <= 0) return;

    if (!entriesAsync.isLoading && entriesAsync.requireValue.hasMore
        && !entriesAsync.requireValue.isLoadingMore
        && _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(entriesProvier(pid).notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildMain() {
    final tileAsync = ref.watch(tileProvider(pid));
    final tile = tileAsync.requireValue;
    return Stack(children: [
       _buildListView(),
      // Positioned(
      //     top: 0, left: 0, right: 0,
      //     child: Visibility(
      //       visible: tile.errorCount > 0,
      //         child: AlertView(
      //           data: tile.errorMsg,
      //         )
      //     )
      // ),
    ],);
  }


  Widget _buildListView() {
    final entriesAsync = ref.watch(entriesProvier(pid));
    final tileAsync = ref.watch(tileProvider(pid));
    final entriesState = entriesAsync.requireValue;
    final tile = tileAsync.requireValue;
    return RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(entriesProvier(pid));
          await ref.read(entriesProvier(pid).future);
        },
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: entriesState.entries.length + 2,
            separatorBuilder: (_, index) => index == 0
                ? const SizedBox.shrink()
                : const SpacerDivider(indent: 0, spacing: 1, thickness: 0.5,),
            itemBuilder: (context, index) {
              if (index == 0) {
                return FeedHeader(
                  title: tile.title,
                  unread: tile.unread,
                  errorCount: tile.errorCount,
                  errorMsg: tile.errorMsg,
                );
              }
              if (index - 1 >= entriesState.entries.length) {
                return entriesState.hasMore ? const LoadingMore() : const NoMoreLoading();
              }
              final entry = entriesState.entries[index - 1];
              return EntryItem(entry: entry, tile: tile);
              // return entry.isUnread
              //     ? EntryItem(entry: entry, tile: tile)
              //     : Opacity(opacity: 0.5,
              //         child: EntryItem(entry: entry, tile: tile),
              //       );
            }));
  }

  Widget _buildSmartSkeleton() {
    return Shimmer.fromColors(
      baseColor: AppTheme.black4,
      highlightColor: AppTheme.black8,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 11,
        separatorBuilder: (_, index) => index == 0
            ? const SizedBox.shrink()
            : const SpacerDivider(indent: 16, spacing: 1, thickness: 0.5, color: Colors.white,),
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
