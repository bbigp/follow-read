import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:follow_read/config/theme.dart';
import 'package:follow_read/features/presentation/widgets/cluster/recent_time.dart';
import 'package:follow_read/features/presentation/widgets/components/spacer_divider.dart';

class ContextMenuWrapper extends StatefulWidget {
  final Widget child; //长按组件
  final List<ContextMenuEntry> menuItems; //弹出菜单

  const ContextMenuWrapper({
    super.key,
    required this.child,
    required this.menuItems,
  });

  @override
  State<ContextMenuWrapper> createState() => _ContextMenuWrapperState();
}

class _ContextMenuWrapperState extends State<ContextMenuWrapper> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
  }

  void _showOverlay() {
    _hideOverlay();
    HapticFeedback.mediumImpact();
    // 获取组件的尺寸和位置
    final RenderBox box = _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = box.localToGlobal(Offset.zero);
    final Size size = box.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 背景模糊
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.transparent,),
          ),
          // 半透明白色遮罩，注意这个 alpha
          GestureDetector(
            onTap: _hideOverlay,
            child: Container(
              color: AppTheme.white6, // 看起来会更接近设计图
            ),
          ),

          // 被点击的组件复制并突出显示
          Positioned(
            left: offset.dx + 16,
            top: offset.dy,
            width: size.width - 32,
            height: size.height,
            child: Material(
              color: Colors.white,
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: widget.child,
            ),
          ),

          // 弹出菜单（在下面）
          Positioned(
            left: offset.dx + 16,
            top: offset.dy + size.height + 10,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              elevation: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.menuItems.map((item) {
                  return InkWell(
                    onTap: () {
                      _hideOverlay();
                      item.getTap()?.call();
                      // 你也可以在这里加入具体的操作回调
                    },
                    child: item.get(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onLongPress: _showOverlay,
      child: widget.child,
    );
  }
}



abstract class ContextMenuEntry {
  Widget get();
  VoidCallback? getTap();
}




