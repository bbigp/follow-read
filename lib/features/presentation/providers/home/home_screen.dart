import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/config/svgicons.dart';
import 'package:follow_read/features/domain/cases/open.dart';
import 'package:follow_read/features/domain/models/sync_task.dart';
import 'package:follow_read/features/presentation/providers/home/home_controller.dart';
import 'package:follow_read/features/presentation/providers/home/home_extension.dart';
import 'package:follow_read/features/presentation/providers/sync_data_provider.dart';
import 'package:follow_read/features/presentation/widgets/components/cupx_app_bar.dart';
import 'package:follow_read/features/presentation/widgets/components/padded_svg_icon.dart';
import 'package:follow_read/features/presentation/widgets/components/sync_icon.dart';
import 'package:follow_read/features/presentation/widgets/feed/empty_feed_view.dart';
import 'package:follow_read/features/presentation/widgets/feed/feed_creator.dart';
import 'package:follow_read/features/presentation/widgets/home/group_tile.dart';
import 'package:follow_read/features/presentation/widgets/home/loading_page.dart';
import 'package:follow_read/features/presentation/widgets/home/sync_view.dart';
import 'package:follow_read/routes/app_route.dart';
import 'package:get/get.dart';

///
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {

  bool _showTip = true;

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
    setState(() {
      _showTip = true;
    });
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



  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();

    final syncState = ref.watch(syncProvider);
    if (syncState.status == SyncTask.success && syncState.refreshUi) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // final _ = ref.refresh(homeProvider);
        ref.read(syncProvider.notifier).resetStatus();
      });
    }

    final widgets = <Widget>[
      SliverToBoxAdapter(child: AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        child: _showTip ? SyncView(skeleton: true,) : SizedBox(height: 0,),
      ),),
      smartGroupView,
      artiadView,
      dividerView,
      SliverToBoxAdapter(child: GroupTile(title: '订阅源',)),
    ];
    if (home.state.feeds.isEmpty && home.state.folders.isEmpty) {
      widgets.add(SliverToBoxAdapter(child: EmptyFeedView(),));
    } else {
      widgets.add(folderView);
      widgets.add(feedView);
    }
    return Scaffold(
      appBar: CupxAppBar(
        leading: PaddedSvgIcon(Svgicons.user_fill, onTap: (){
          ref.read(routerProvider).pushNamed(RouteNames.profile);
        },),
        actions: [
          PaddedSvgIcon(Svgicons.add, onTap: () => Open.modal(context, FeedCreator())),
          SyncIcon(),
          PaddedSvgIcon(Svgicons.more,),
        ],
      ),
      body: Obx((){
        return home.state.isLoading
            ? const LoadingPage()
            : Stack(
          children: [
            RefreshIndicator(onRefresh: _refreshData,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [...widgets],
                )
            ),
            Positioned(
                left: 0, right: 0, top: 0,
                child: AnimatedOpacity( //变淡效果
                  opacity: _showTip ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  onEnd: (){
                    if (!_showTip) {
                      setState(() {}); // 触发 AnimatedSize
                    }
                  },
                  child: GestureDetector(onTap: () {
                    setState(() {
                      _showTip = false;
                    });
                  },
                    child: SyncView(),
                  ),
                )
            )
          ],
        );
      }),
    );
  }
}


// AlwaysStickyHeader(
// enableDismiss: true,
// child: SyncView(),
// ),


class AlwaysStickyHeader extends StatefulWidget {
  final Widget child;
  final bool enableDismiss;

  const AlwaysStickyHeader({
    super.key,
    required this.child,
    this.enableDismiss = false,
  });

  @override
  State<AlwaysStickyHeader> createState() => _AlwaysStickyHeaderState();
}

class _AlwaysStickyHeaderState extends State<AlwaysStickyHeader> {
  bool _visible = true;
  final GlobalKey _key = GlobalKey();
  double _height = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateHeight());
  }

  void _updateHeight() {
    final context = _key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      setState(() {
        _height = box.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverPersistentHeader(
      pinned: true,
      delegate: _AlwaysStickyHeaderDelegate(
        height: _height == 0 ? 60 : _height, // 先给默认高度
        child: GestureDetector(
          key: _key,
          behavior: HitTestBehavior.translucent,
          onTap: widget.enableDismiss
              ? () {
            setState(() {
              _visible = false;
            });
          }
              : null,
          child: widget.child,
        ),
      ),
    );
  }
}

class _AlwaysStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _AlwaysStickyHeaderDelegate({
    required this.height,
    required this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _AlwaysStickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}

