

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/dashed_line.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/sync_icon.dart';
import 'package:follow_read/modules/sync/sync_controller.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import '../home_tile/feed_tile.dart';
import '../home_tile/filter_tile.dart';
import '../home_tile/folder_tile.dart';
import '../home_tile/group_tile.dart';
import 'home_controller.dart';
import 'loading_page.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin, WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController.addListener(_scrollListener);
    sync.sync(checkInterval: true);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).unfocus(); // 收起键盘
    // });
  }

  final ScrollController _scrollController = ScrollController();

  Future<void> _refreshData() async {
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {}
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      sync.sync(checkInterval: true);
    }
  }

  final home = Get.find<HomeController>();
  final sync = Get.find<SyncController>();

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      SliverToBoxAdapter(
        child: GroupTile(title: '智能视图', trailing: AddTrailing(
            onTap: () => Get.toNamed(RouteConfig.filter)
        )),
      ),
      Obx((){
        return SliverList(key: ValueKey("filters"), delegate: SliverChildBuilderDelegate(childCount: home.state.filters.length, (context, index) {
          return FilterTile(filter: home.state.filters[index], controller: home,);
        }));
      }),
      SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
          child: DashedDivider(indent: 0, thickness: 0.5, spacing: 0, color: AppColors.black08,),
      ),),
      SliverToBoxAdapter(child: GroupTile(title: '订阅源',)),
      Obx(() {
        return SliverList(key: ValueKey("folders"), delegate: SliverChildBuilderDelegate(childCount: home.state.folders.length, (context, index) {
          return FolderTile(folder: home.state.folders[index], controller: home,);
        }));
      }),
      Obx(() {
        return SliverList(key: ValueKey("feeds"), delegate: SliverChildBuilderDelegate(childCount: home.state.feeds.length, (context, index) {
          return FeedTile(feed: home.state.feeds[index]);
        }));
      }),
    ];
    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(SvgIcons.lines_3, onTap: () => Get.toNamed(RouteConfig.profile),),
        actions: [
          PaddedSvgIcon(SvgIcons.add, onTap: () => Get.toNamed(RouteConfig.searchFeed)
          //     Open.modal(context, GetModalWrapper(
          //   initControllers: () {
          //     Get.put(AddFeedController(id: BigInt.zero));
          //   },
          //   disposeControllers: () => Get.delete<AddFeedController>(),
          //   builder: () => AddFeedForm(),
          // ))
          ),
          Obx(() {
            return SyncIcon(isSyncing: sync.state.isSyncing, onTap: () => sync.sync(),);
          }),
          // PaddedSvgIcon(SvgIcons.more,),
        ],
      ),
      body: Obx((){
        return home.state.isLoading
            ? const LoadingPage()
            : RefreshIndicator(
                onRefresh: _refreshData,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [...widgets],
                ));
      }),
    );
  }

}