

import 'package:flutter/material.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/providers/home/home_screen.dart';
import 'package:follow_read/features/presentation/widgets/components/dashed_line.dart';
import 'package:follow_read/features/presentation/widgets/home/cluster_tile.dart';
import 'package:follow_read/features/presentation/widgets/home/feed_tile.dart';
import 'package:follow_read/features/presentation/widgets/home/folder_tile.dart';
import 'package:follow_read/features/presentation/widgets/home/group_tile.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

extension HomeExtension on HomeScreenState {

  Widget get folderView => Obx(() {
    final home = Get.find<HomeController>();
    return SliverList(delegate: SliverChildBuilderDelegate(
      childCount: home.state.folderLen, (context, index) {

    return GetBuilder<HomeController>(builder: (controller) {
      final folder = controller.state.folders[index];
      return FolderTile(folder: folder);
    }, id: 'folder_tile:$index',);
  }
  ));});


  Widget get feedView => Obx(() {
    final home = Get.find<HomeController>();
    return SliverList(delegate: SliverChildBuilderDelegate(
        childCount: home.state.feedLen, (context, index) {

      return GetBuilder<HomeController>(builder: (controller) {
        final feed = controller.state.feeds[index];
        return FeedTile(feed: feed);
      }, id: 'feed_tile:$index',);
    }
    ));
  });

  Widget get artiadView => Obx((){
    final home = Get.find<HomeController>();
    return SliverList(delegate: SliverChildBuilderDelegate(
        childCount: home.state.artiadLen, (context, index) {

      return GetBuilder<HomeController>(builder: (controller){
        final artiad = controller.state.artiads[index];
        return ClusterTile(artiad: artiad);
      }, id: "artiad_tile:$index}",);
    }
    ));
  });

  Widget get smartGroupView => SliverToBoxAdapter(
    child: GroupTile(title: '智能视图', trailing: AddTrailing(onTap: () {
      ref.read(routerProvider).pushNamed(RouteNames.cluster,);
    })),
  );
  Widget get dividerView => SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
      child: DashedDivider(indent: 0, thickness: 0.5, spacing: 0, color: AppTheme.black8,),
    ),
  );



}