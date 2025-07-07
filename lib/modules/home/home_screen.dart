

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/dashed_line.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/sync_icon.dart';
import 'package:follow_read/modules/feed/empty_feed_view.dart';
import 'package:follow_read/modules/feed/feed_form.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/modules/sync/sync_controller.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import 'feed_tile.dart';
import 'folder_tile.dart';
import 'group_tile.dart';
import 'home_controller.dart';
import 'loading_page.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus(); // 收起键盘
    });
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
    super.dispose();
  }

  final home = Get.find<HomeController>();
  final sync = Get.find<SyncController>();

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      SliverToBoxAdapter(
        child: GroupTile(title: '智能视图', trailing: AddTrailing(onTap: () {
        })),
      ),
      // artiadView,
      // Widget get artiadView => Obx((){
      //   final home = Get.find<HomeController>();
      //   return SliverList(delegate: SliverChildBuilderDelegate(
      //       childCount: home.state.artiadLen, (context, index) {
      //
      //     return GetBuilder<HomeController>(builder: (controller){
      //       final artiad = controller.state.artiads[index];
      //       return ClusterTile(artiad: artiad);
      //     }, id: "artiad_tile:$index}",);
      //   }
      //   ));
      // });
      SliverToBoxAdapter(child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
          child: DashedDivider(indent: 0, thickness: 0.5, spacing: 0, color: AppColors.black08,),
      ),),
      SliverToBoxAdapter(child: GroupTile(title: '订阅源',)),
      Obx(() {
        return SliverList(delegate: SliverChildBuilderDelegate(childCount: home.state.folderLen, (context, index) {
          return GetBuilder<HomeController>(builder: (controller) {
            final folder = controller.state.folders[index];
            return FolderTile(folder: folder, controller: controller,);
          }, id: 'folder_tile:$index',);
        }));
      }),
      Obx(() {
        return SliverList(delegate: SliverChildBuilderDelegate(childCount: home.state.feedLen, (context, index) {
          return GetBuilder<HomeController>(builder: (controller) {
            final feed = controller.state.feeds[index];
            return FeedTile(feed: feed);
          }, id: 'feed_tile:$index',);
        }));
      }),
    ];
    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(SvgIcons.lines_3, onTap: (){
          Get.toNamed(RouteConfig.profile);
        },),
        actions: [
          PaddedSvgIcon(SvgIcons.add, onTap: () => Open.modal(context, FeedForm())),
          Obx(() {
            return SyncIcon(isSyncing: sync.state.isSyncing, onTap: () {
              sync.sync();
            },);
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