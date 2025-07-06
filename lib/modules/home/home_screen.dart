

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/global/widgets/cupx_app_bar.dart';
import 'package:follow_read/global/widgets/padded_svg_icon.dart';
import 'package:follow_read/global/widgets/sync_icon.dart';
import 'package:follow_read/modules/feed/empty_feed_view.dart';
import 'package:follow_read/modules/feed/feed_form.dart';
import 'package:follow_read/global/widgets/open.dart';
import 'package:follow_read/modules/sync/sync_controller.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

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
    final widgets = [
      // smartGroupView,
      // artiadView,
      // dividerView,
      SliverToBoxAdapter(child: GroupTile(title: '订阅源',)),
    ];
    if (home.state.feeds.isEmpty && home.state.folders.isEmpty) {
      widgets.add(SliverToBoxAdapter(child: EmptyFeedView(),));
    } else {
      // widgets.add(folderView);
      // widgets.add(feedView);
    }
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