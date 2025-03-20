import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/presentation/widgets/entry_item.dart';
import 'package:follow_read/features/presentation/widgets/feed_header.dart';
import 'package:follow_read/features/presentation/widgets/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/no_more_loading.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/theme.dart';
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
      ref
          .watch(entriesLoadingProvider.notifier)
          .fetchEntries(feedId: widget.feedId, reset: true);
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
                      return FeedHeader(title: 'All', subTitle: '99+未读');
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