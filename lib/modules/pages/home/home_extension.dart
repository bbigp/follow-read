

import 'package:flutter/material.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/app_route.dart';
import 'package:follow_read/modules/controller/home/home_controller.dart';
import 'package:follow_read/modules/widgets/acx/dashed_line.dart';
import 'package:follow_read/modules/widgets/feed/feed_picker.dart';
import 'package:follow_read/modules/widgets/home/cluster_tile.dart';
import 'package:follow_read/modules/widgets/home/feed_tile.dart';
import 'package:follow_read/modules/widgets/home/folder_tile.dart';
import 'package:follow_read/modules/widgets/home/group_tile.dart';
import 'package:follow_read/service/open.dart';
import 'package:get/get.dart';

import 'home_screen.dart';



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