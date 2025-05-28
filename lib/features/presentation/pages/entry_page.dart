
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/entry_page_provider.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_app_bar.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/entry/feed_summary.dart';
import 'package:follow_read/features/presentation/widgets/entry/entry_tile.dart';
import 'package:follow_read/features/presentation/widgets/entry/skeleton_entry_item.dart';
import 'package:follow_read/features/presentation/widgets/feed/feed_settings_sheet.dart';
import 'package:follow_read/features/presentation/widgets/components/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/components/no_more.dart';
import 'package:follow_read/features/presentation/widgets/open_modal.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:shimmer/shimmer.dart';


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
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(Svgicons.arrow_left, onTap: (){
          Navigator.of(context).pop();
        },),
        actions: [
          InkWell(onTap: (){
              ref.read(routerProvider).pushNamed(RouteNames.search, pathParameters: {
                'id': widget.id.toString(), 'type': widget.type.toString(),
              });
          }, child: PaddedSvgIcon(Svgicons.search),),
          InkWell(onTap: (){
            OpenModal.open(context,
                FeedSettingsSheet(id: widget.id, type: widget.type,),
                scrollable: true
            );
          }, child: PaddedSvgIcon(Svgicons.more),)
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

    final entriesAsync = ref.watch(entriesProvier(pid));
    final entriesState = entriesAsync.requireValue;

    return Stack(children: [
      RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(entriesProvier(pid));
          await ref.read(entriesProvier(pid).future);
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [

            SliverToBoxAdapter(child: FeedSummary(feed: tile),),
            SliverList(delegate: SliverChildBuilderDelegate(
              childCount: entriesState.entries.length,
              (context, index) {
                final entry = entriesState.entries[index];
                return EntryTile(entry: entry);
              }
            )),
            SliverToBoxAdapter(child: entriesState.hasMore ? const LoadingMore() : const NoMore(),)
          ]
        ),
      ),
    ],);
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
            ? FeedSummarySkeleton()
            : SkeletonEntryItem(),
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
