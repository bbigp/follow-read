

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/core/themes/app_colors.dart';
import 'package:follow_read/data/model/folder.dart';
import 'package:follow_read/global/widgets/spacer_divider.dart';
import 'package:follow_read/modules/home/home_controller.dart';
import 'package:follow_read/modules/widgets/feed_icon.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import 'main_tile.dart';


///
class FolderTile extends StatelessWidget  {

  final Folder folder;
  final HomeController controller;
  const FolderTile({super.key, required this.folder, required this.controller,});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainTile(
        id: 'o${folder.id}',
        icon: SizedBox(width: 24, height: 24, child: SvgPicture.asset(SvgIcons.group, width: 24, height: 14, fit: BoxFit.contain,),),
        title: folder.title,
        leadingIndicator: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              folder.expanded ? SvgIcons.triangle_down : SvgIcons.triangle_right,
              width: 24, height: 24, fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                AppColors.black50,
                BlendMode.srcIn,
              ),
            ),
          ),
        leadingIndicatorTap: () => controller.expanded(folder.id),
        onTap: () => Get.toNamed(RouteConfig.entries, parameters: {"id": "o${folder.id}"}),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12 + 24 + 4, right: 16),
        child: SpacerDivider(thickness: 0.5, spacing: 0.5, indent: 0,),
      ),
      VerticalExpand(
        expanded: folder.expanded,
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final feed = folder.feeds[index];
              return Column(children: [
                MainTile(
                  id: 'e${feed.id}',
                  title: feed.title,
                  icon: FeedIcon(title: feed.title, iconUrl: feed.iconUrl, size: 24,),
                  contextMenus: feed.contextMenus(context),
                  leadingIndicator: SizedBox(width: 24,),
                  onTap: () => Get.toNamed(RouteConfig.entries, parameters: {"id": "e${feed.id}"}),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12 + 24 + 4, right: 16),
                  child: SpacerDivider(thickness: 0.5, spacing: 0.5, indent: 0,),
                ),
              ],);
            },
            itemCount: folder.feeds.length
        ),
      )
    ],);
  }
}

class VerticalExpand extends StatefulWidget {
  final bool expanded;
  final Widget child;
  final Duration duration;

  const VerticalExpand({
    super.key,
    required this.expanded,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<VerticalExpand> createState() => _VerticalExpandState();
}

class _VerticalExpandState extends State<VerticalExpand> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (widget.expanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant VerticalExpand oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != oldWidget.expanded) {
      if (widget.expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizeTransition(
        axis: Axis.vertical,
        axisAlignment: -1, // 关键！表示动画从上边开始展开和收缩
        sizeFactor: _animation,
        child: widget.child,
      ),
    );
  }
}
