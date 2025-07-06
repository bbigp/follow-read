

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PopupWrapper {
  static OverlayEntry? _entry;
  static GlobalKey? _currentTargetKey;// 当前关联的目标组件的Key

  static void show({
    required BuildContext context,
    required GlobalKey targetKey, // 目标组件的Key
    required Widget child,  // 要显示的菜单内容
    EdgeInsets offset = const EdgeInsets.only(top: 4), // 与目标的偏移量
    VoidCallback? onDismiss,
    Duration animationDuration = const Duration(milliseconds: 200),
  }) {
    // 如果当前已经有菜单显示并且目标相同，则先隐藏它
    if (_currentTargetKey == targetKey && _entry != null) {
      hide();
      return;
    }
    hide(); // 确保之前的菜单已经隐藏

    // 获取目标组件的渲染信息
    final RenderBox? targetBox = targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (targetBox == null) return; // 如果目标组件不存在或不可见，则直接返回

    // 获取目标组件的尺寸和在屏幕中的位置
    final Size targetSize = targetBox.size;
    final Offset targetPosition = targetBox.localToGlobal(Offset.zero);

    // 获取Overlay状态和屏幕尺寸
    final OverlayState overlayState = Overlay.of(context);
    final Size screenSize = MediaQuery.of(context).size;

    // 创建用于测量的Key
    final GlobalKey measureKey = GlobalKey();

    // 创建测量用的OverlayEntry
    OverlayEntry? measureEntry;
    measureEntry = OverlayEntry(builder: (context) {
      // 使用LayoutBuilder确保约束在正确的上下文中应用
      return LayoutBuilder(builder: (context, constraints) {
        // 定义测量约束：最大为屏幕的80%宽和60%高
        final BoxConstraints measureConstraints = BoxConstraints(
          maxWidth: screenSize.width * 0.8,
          maxHeight: screenSize.height * 0.6,
        );
        // 返回测量组件
        return MeasureSize(
          key: measureKey,
          constraints: measureConstraints,
          onChange: (size) {
            debugPrint('Measured with constraints: $measureConstraints | Size: $size');
            // 移除测量层
            measureEntry?.remove();
            // 获取菜单尺寸
            double menuWidth = size.width;
            double menuHeight = size.height;
            // 如果测量结果仍然很大，强制限制尺寸
            if (menuHeight > screenSize.height * 0.6) {
              menuHeight = screenSize.height * 0.6;
            }
            debugPrint('Final menu size: $menuWidth x $menuHeight');

            // 计算可用的屏幕空间
            final double spaceBelow = screenSize.height - (targetPosition.dy + targetSize.height) - offset.top;
            final double spaceAbove = targetPosition.dy - offset.top;

            // 确定菜单位置：上方或下方
            double top;
            bool showBelow = spaceBelow > spaceAbove;
            if (showBelow) {
              // 在目标下方显示：目标Y坐标 + 目标高度 + 顶部偏移 (y坐标，点击组件的作为上脚 + 点击组件高度 + 弹出菜单位于点击组件4px）
              top = targetPosition.dy + targetSize.height + offset.top;
            } else {
              // 在目标上方显示：目标Y坐标 - 菜单高度 - 顶部偏移
              top = targetPosition.dy - menuHeight - offset.top;
            }

            // 计算菜单水平位置（从目标右侧开始）
            double left = targetPosition.dx + targetSize.width - menuWidth;
            if (left < 16) left = 16;
            if (left + menuWidth + 16 > screenSize.width) { // 确保菜单不会超出屏幕左侧
              left = screenSize.width - menuWidth - 16;
            }

            // 确保菜单在屏幕顶部边界内
            if (top < 0) {
              top = 8.0;
              // 限制菜单高度不要超出屏幕
              menuHeight = menuHeight.clamp(0, screenSize.height - 16);
            }
            // 确保菜单在屏幕底部边界内
            final double maxBottom = top + menuHeight;
            if (maxBottom > screenSize.height - 8) {
              menuHeight = screenSize.height - top - 8;
            }

            // 创建菜单动画控制器
            final animationController = AnimationController(
              duration: animationDuration,
              vsync: Navigator.of(context),
            );
            // 创建曲线动画
            final animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

            // 创建实际的菜单OverlayEntry
            _entry  = OverlayEntry(
              builder: (_) => _PopupWrapperWidget(
                animation: animation,
                onTapOutside: () {
                  hide(); // 点击外部关闭菜单
                  onDismiss?.call(); // 调用关闭回调
                },
                left: left,
                top: top,
                width: menuWidth,
                height: menuHeight,
                child: child,
              ),
            );

            overlayState.insert(_entry!);// 插入菜单到Overlay
            animationController.forward();// 启动动画
            _currentTargetKey = targetKey;// 记录当前目标Key

            _removeListener = () {// 设置资源清理回调
              animationController.dispose();
            };
          },
          child: Opacity(
            opacity: 0, // 测量期间实际不可见
            child: Material(child: child,),
          ),
        );
      });
    });

    // 插入测量层到Overlay
    overlayState.insert(measureEntry);
  }

  static VoidCallback? _removeListener;

  static void hide() {
    _entry?.remove();
    _entry = null;
    _currentTargetKey = null;
    _removeListener?.call();
    _removeListener = null;
  }
}

class _PopupWrapperWidget extends StatefulWidget {
  final Animation<double> animation;
  final VoidCallback onTapOutside;
  final double left;
  final double top;
  final double width;
  final double height;
  final Widget child;

  const _PopupWrapperWidget({
    required this.animation,
    required this.onTapOutside,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  State<_PopupWrapperWidget> createState() => _PopupWrapperWidgetState();
}

class _PopupWrapperWidgetState extends State<_PopupWrapperWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 创建透明覆盖层用于检测点击外部
        GestureDetector(
          behavior: HitTestBehavior.translucent, // 允许检测透明区域点击
          onTap: widget.onTapOutside, // 点击关闭菜单
          child: Container(color: Colors.transparent),
        ),
        Positioned(
          left: widget.left,
          top: widget.top,
          width: widget.width,
          height: widget.height,
          child: FadeTransition(// 淡入淡出动画
            opacity: widget.animation,
            child: Material(
              elevation: 8,
              color: Colors.transparent,
              // borderRadius: BorderRadius.circular(8), // 圆角
              // clipBehavior: Clip.antiAlias, // 抗锯齿裁剪
              child: widget.child,
            ),
          ),
        ),
      ],
    );
  }

}


typedef OnWidgetSizeChange = void Function(Size size);

// MeasureSize 小部件：用于测量其子部件的尺寸
class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;
  final BoxConstraints constraints;// 测量时要应用的约束

  const MeasureSize({
    super.key,
    required this.onChange,
    required this.constraints,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMeasureSize(onChange, constraints);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderMeasureSize renderObject) {
    renderObject.onChange = onChange;
    renderObject.constraints = constraints;
  }
}

class _RenderMeasureSize extends RenderProxyBox {
  OnWidgetSizeChange onChange;
  @override
  BoxConstraints constraints;
  Size? _oldSize;

  _RenderMeasureSize(this.onChange, this.constraints);

  @override
  void performLayout() {
    // 应用约束：确保子部件符合指定的约束
    final BoxConstraints effectiveConstraints = constraints.enforce(constraints);
    // 布局子部件，并允许父部件使用子部件的尺寸
    child!.layout(effectiveConstraints, parentUsesSize: true);
    // 设置当前渲染对象的尺寸为约束的最大值
    size = Size(effectiveConstraints.maxWidth, effectiveConstraints.maxHeight);

    Size newSize = child!.size;// 获取子部件的实际尺寸
    // 如果尺寸没有变化，则直接返回
    if (_oldSize == newSize) return;
    _oldSize = newSize;
    // 在布局完成后的一帧中调用尺寸变化回调
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}