
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/domain/cases/base.dart';
import 'package:follow_read/features/presentation/providers/entryhub/entryhub_controller.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_app_bar.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';
import 'package:follow_read/features/presentation/widgets/entry/feed_summary.dart';
import 'package:follow_read/features/presentation/widgets/entry/entry_tile.dart';
import 'package:follow_read/features/presentation/widgets/components/loading_more.dart';
import 'package:follow_read/features/presentation/widgets/components/no_more.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class EntryPage extends ConsumerStatefulWidget {
  final MetaDatax metaDatax;

  const EntryPage({super.key, required this.metaDatax,});

  @override
  ConsumerState<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends ConsumerState<EntryPage> {
  final ScrollController _scrollController = ScrollController();
  final controller = Get.find<EntryhubController>();

  void _scrollListener() {
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
    Get.put(EntryhubController(widget.metaDatax));
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    Get.delete<EntryhubController>();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print("A页面 build 被调用 ${controller.state.isLoading}");
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
    return Stack(children: [
      RefreshIndicator(
        onRefresh: () async {
          controller.init();
        },
        child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: FeedSummary(metaDatax: widget.metaDatax),), //滚动到appbar https://blog.csdn.net/yechaoa/article/details/90701321
              GetBuilder<EntryhubController>(builder: (controller){
                return SliverList(delegate: SliverChildBuilderDelegate(
                    childCount: controller.state.entries.length, (context, index) {
                      return EntryTile(entry: controller.state.entries[index]);
                    }
                ));
              }),
              Obx((){
                return SliverToBoxAdapter(child: controller.state.hasMore ? const LoadingMore() : const NoMore(),);
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
