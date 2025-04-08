import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/constants.dart';
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
import '../widgets/feed_icon.dart';
import '../widgets/spacer_divider.dart';

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
      body: entriesAsync.isLoading
          ? _buildSmartSkeleton()
          : _buildListView(),
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
              final tileAsync = ref.watch(tileProvider(pid));
              final tile = tileAsync.requireValue;
              return Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 顶部拖拽指示条
                    _buildDragHandle(),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding: EdgeInsets.all(6),
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 1,
                          color: AppTheme.black8
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 6,),
                          FeedIcon(title: tile.title, iconUrl: tile.iconUrl, size: 36,),
                          SizedBox(width: 12,),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(tile.title,
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black95,
                              ),),
                              Text(tile.feedUrl,
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400, height: 1.38, color: AppTheme.black50,
                              ),),
                            ],
                          )),
                          SizedBox(width: 8,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppTheme.black8,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            child: SvgPicture.asset(
                              Svgicons.edit,
                              height: 20, width: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    // 排序选项
                    SizedBox(height: 16,),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text(
                      '排序', style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500, height: 1.33, color: AppTheme.black50,
                    ),
                    ),),
                    SizedBox(height: 6,),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppTheme.black8,
                        ),
                        height: 48,
                        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                          final width = (constraints.maxWidth - 8) / 2;
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  if (tile.orderx == Frc.orderxPublishedAt) return;
                                  ref.read(tileProvider(pid).notifier).saveShow(orderx: Frc.orderxPublishedAt);
                                },
                                child: Container(
                                  decoration: tile.orderx == Frc.orderxPublishedAt ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ) : null,
                                  margin: tile.orderx == Frc.orderxPublishedAt ? EdgeInsets.all(4) : null,
                                  width: width,
                                  alignment: Alignment.center,
                                  child: Text('发布时间', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33,
                                    color: tile.orderx == Frc.orderxPublishedAt ? AppTheme.black95: AppTheme.black50,
                                  ),),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  if (tile.orderx == Frc.orderxCreatedAt) return;
                                  ref.read(tileProvider(pid).notifier).saveShow(orderx: Frc.orderxCreatedAt);
                                },
                                child: Container(
                                  decoration: tile.orderx == Frc.orderxCreatedAt ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ) : null,
                                  margin: tile.orderx == Frc.orderxCreatedAt ? EdgeInsets.all(4) : null,
                                  width: width,
                                  alignment: Alignment.center,
                                  child: Text('添加时间', style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500, height: 1.33,
                                    color: tile.orderx == Frc.orderxCreatedAt ? AppTheme.black95: AppTheme.black50,
                                  ),),
                                ),
                              ),
                            ],
                          );
                        },),
                      ),
                    ),
                    SizedBox(height: 16,),
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
