
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/domain/cases/base.dart';
import 'package:follow_read/features/domain/models/entry.dart';
import 'package:follow_read/features/domain/cases/page_info.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_app_bar.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/entry/feed_summary.dart';
import 'package:follow_read/features/presentation/widgets/entry/entry_tile.dart';
import 'package:follow_read/features/presentation/widgets/components/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/components/no_more.dart';
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

  void _scrollListener() {
    final entriesAsync = widget.metaDatax.page(ref);
    if (entriesAsync.isLoading) return;
    if (!entriesAsync.requireValue.hasMore) return;
    if (entriesAsync.requireValue.isLoadingMore) return;

    final position = _scrollController.position;
    // 空列表或未加载完成时直接返回
    if (position.maxScrollExtent <= 0) return;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      widget.metaDatax.loadMore(ref);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final entriesAsync = widget.metaDatax.page(ref);
    print("A页面 build 被调用 ${entriesAsync.isLoading}");
    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(Svgicons.arrow_left, onTap: (){
          Navigator.of(context).pop();
        },),
        actions: [
          InkWell(onTap: (){
            ref.read(routerProvider).pushNamed(RouteNames.search, pathParameters: {
              'id': widget.metaDatax.id.toString(), 'type': widget.metaDatax.type,
            });
          }, child: PaddedSvgIcon(Svgicons.search),),
          InkWell(onTap: (){
          }, child: PaddedSvgIcon(Svgicons.more),)
        ],
      ),
      body: entriesAsync.isLoading
          ? _buildSmartSkeleton()
          : _buildMain(entriesAsync.requireValue),
    );
  }


  // OpenModal.open(context,
  //     FeedSettingsSheet(id: widget.id, type: widget.type,),
  //     scrollable: true
  // );


  Widget _buildMain(PageInfo<Entry> pageInfo) {
    final list = pageInfo.list;
    return Stack(children: [
      RefreshIndicator(
        onRefresh: () async {
          widget.metaDatax.refresh(ref);
        },
        child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: FeedSummary(metaDatax: widget.metaDatax),), //滚动到appbar https://blog.csdn.net/yechaoa/article/details/90701321
              SliverList(delegate: SliverChildBuilderDelegate(
                  childCount: list.length, (context, index) {
                    return EntryTile(entry: list[index]);
                  }
              )),
              SliverToBoxAdapter(child: pageInfo.hasMore ? const LoadingMore() : const NoMore(),)
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
            : EntryTileSkeleton(),
      ),
    );
  }

}
