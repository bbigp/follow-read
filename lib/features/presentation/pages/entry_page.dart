
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/models/feedx.dart';
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
  final MetaDatax metaDatax;

  const EntryPage({super.key, required this.metaDatax,});

  @override
  ConsumerState<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }


  @override
  Widget build(BuildContext context) {
    final metaAsync = widget.metaDatax.get(ref);
    final entriesAsync = ref.watch(entriesProvier(""));

    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(Svgicons.arrow_left, onTap: (){
          Navigator.of(context).pop();
        },),
        actions: [
          InkWell(onTap: (){
              // ref.read(routerProvider).pushNamed(RouteNames.search, pathParameters: {
              //   'id': widget.id.toString(), 'type': widget.type.toString(),
              // });
          }, child: PaddedSvgIcon(Svgicons.search),),
          InkWell(onTap: (){
            // OpenModal.open(context,
            //     FeedSettingsSheet(id: widget.id, type: widget.type,),
            //     scrollable: true
            // );
          }, child: PaddedSvgIcon(Svgicons.more),)
        ],
      ),
      body: metaAsync.isLoading ? _buildSmartSkeleton() : _buildMain(),
    );
  }



  void _scrollListener() {
    // final entriesAsync = ref.watch(entriesProvier(pid));
    // final position = _scrollController.position;

    // 空列表或未加载完成时直接返回
    // if (position.maxScrollExtent <= 0) return;

    // if (!entriesAsync.isLoading && entriesAsync.requireValue.hasMore
    //     && !entriesAsync.requireValue.isLoadingMore
    //     && _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      // ref.read(entriesProvier(pid).notifier).loadMore();
    // }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildMain() {
    // final tileAsync = ref.watch(tileProvider(""));
    // final tile = tileAsync.requireValue;
    //
    // final entriesAsync = ref.watch(entriesProvier(""));
    // final entriesState = entriesAsync.requireValue;
    List<Entry> list = [];

    final mate = ref.watch(mataProvider(widget.iMata)).requireValue;

    return Stack(children: [
      RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(entriesProvier(""));
          await ref.read(entriesProvier("").future);
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [

            SliverToBoxAdapter(child: FeedSummary(feed: mate),),
            SliverList(delegate: SliverChildBuilderDelegate(
              childCount: 0,
              (context, index) {
                final entry = list[index];
                return EntryTile(entry: entry);
              }
            )),
            SliverToBoxAdapter(child: false ? const LoadingMore() : const NoMore(),)
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

}
