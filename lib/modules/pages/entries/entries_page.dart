
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/modules/controller/entries/entries_controller.dart';
import 'package:follow_read/modules/widgets/acx/cupx_app_bar.dart';
import 'package:follow_read/modules/widgets/acx/loading_more.dart';
import 'package:follow_read/modules/widgets/acx/no_more.dart';
import 'package:follow_read/modules/widgets/acx/padded_svg_icon.dart';
import 'package:follow_read/modules/widgets/acx/spacer_divider.dart';
import 'package:follow_read/modules/widgets/entry/feed_summary.dart';
import 'package:follow_read/modules/widgets/entry/entry_tile.dart';
import 'package:follow_read/app_route.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'meta_data.dart';


class EntriesPage extends ConsumerStatefulWidget {
  final MetaDatax metaDatax;

  const EntriesPage({super.key, required this.metaDatax,});

  @override
  ConsumerState<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends ConsumerState<EntriesPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    final controller = Get.find<EntriesController>();
    if (controller.state.isLoading) return;
    if (!controller.state.hasMore) return;
    if (controller.state.isLoadingMore) return;

    final position = _scrollController.position;
    // 空列表或未加载完成时直接返回
    if (position.maxScrollExtent <= 0) return;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      controller.nextPage();
    }
  }

  @override
  void initState() {
    super.initState();
    Get.put(EntriesController(widget.metaDatax));
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    Get.delete<EntriesController>();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EntriesController>();
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
      body: Obx((){
        return controller.state.isLoading ? _buildSmartSkeleton() : _buildMain();
      }),
    );
  }


  // OpenModal.open(context,
  //     FeedSettingsSheet(id: widget.id, type: widget.type,),
  //     scrollable: true
  // );


  Widget _buildMain() {
    final controller = Get.find<EntriesController>();
    return Stack(children: [
      RefreshIndicator(
        onRefresh: () async {
          await controller.init();
        },
        child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: FeedSummary(meta: controller.state.meta),), //滚动到appbar https://blog.csdn.net/yechaoa/article/details/90701321
              Obx(() {
                return SliverList(delegate: SliverChildBuilderDelegate(
                    childCount: controller.state.len,
                        (context, index) {
                      return GetBuilder<EntriesController>(builder: (controller) {
                        final entry = controller.state.entries[index];
                        return EntryTile(entry: entry);
                      }, id: "entry_tile:$index",);
                }));
              }),
              Obx((){
                return SliverToBoxAdapter(child: controller.state.hasMore
                    ? const LoadingMore()
                    : const NoMore()
                );
              }),

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
