


import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/loading_more.dart';
import 'package:follow_read/global/widgets/no_more.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/modules/entries/entries_controller.dart';
import 'package:follow_read/modules/entry_tile/entry_tile.dart';
import 'package:follow_read/modules/entries/entries_summary.dart';
import 'package:follow_read/modules/home_tile/tile_settings.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class EntriesPage extends StatefulWidget {

  const EntriesPage({super.key});

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {

  final ScrollController _scrollController = ScrollController();

  final ec = Get.find<EntriesController>();

  void _scrollListener() {
    if (ec.state.isLoading) return;
    if (!ec.state.hasMore) return;
    if (ec.state.isLoadingMore) return;

    final position = _scrollController.position;
    // 空列表或未加载完成时直接返回
    if (position.maxScrollExtent <= 0) return;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ec.nextPage();
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
    final controller = Get.find<EntriesController>();
    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(SvgIcons.arrow_left, onTap: (){
          Navigator.of(context).pop();
        },),
        actions: [
          InkWell(onTap: () => Get.toNamed(RouteConfig.search), child: PaddedSvgIcon(SvgIcons.search),),
          InkWell(onTap: () => Open.modal(context, TileSettings()), child: PaddedSvgIcon(SvgIcons.more),)
        ],
      ),
      body: Obx((){
        return controller.state.isLoading ? _buildSmartSkeleton() : _buildMain();
      }),
    );
  }


  Widget _buildMain() {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => ec.init(),
          child: CustomScrollView(controller: _scrollController, slivers: [
            SliverToBoxAdapter(child: EntriesSummary(meta: ec.state.meta)),
            //滚动到appbar https://blog.csdn.net/yechaoa/article/details/90701321
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: ec.state.items.length, (context, index) {
              return EntryTile(entryObs: ec.state.items[index]);
            })),
            Obx(() {
              return SliverToBoxAdapter(
                  child: ec.state.hasMore ? const LoadingMore() : const NoMore());
            }),
          ]),
        ),
      ],
    );
  }

  Widget _buildSmartSkeleton() {
    return Shimmer.fromColors(
      baseColor: AppColors.black04,
      highlightColor: AppColors.black08,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 11,
        separatorBuilder: (_, index) => index == 0
            ? const SizedBox.shrink()
            : const SpacerDivider(indent: 16, spacing: 1, thickness: 0.5, color: Colors.white,),
        itemBuilder: (context, index) => index == 0
            ? EntriesSummarySkeleton()
            : EntryTileSkeleton(),
      ),
    );
  }


}