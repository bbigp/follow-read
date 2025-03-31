import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/material.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:follow_read/features/presentation/widgets/svgicon.dart';

const double _kDragContainerExtentPercentage = 0.1; //下拉到百分之多少触发
const double _kDragSizeFactorLimit = 1;

typedef RefreshCallback = Future<void> Function();

enum RefreshIndicatorStatus {
  drag, //用户开始下拉但未达触发阈值
  armed, //下拉距离达到或超过触发阈值
  snap, //用户释放手指后，准备执行刷新前的动画
  refresh, //正式执行刷新操作
  done, //刷新成功完成
  canceled, //刷新被中止（如中途滑动取消）
}

class CustomRefresh extends StatefulWidget {
  const CustomRefresh({
    super.key,
    required this.child,
    this.edgeOffset = 0.0,
    required this.onRefresh,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  }) : onStatusChange = null;

  const CustomRefresh.noSpinner({
    super.key,
    required this.child,
    required this.onRefresh,
    this.onStatusChange,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  }) : edgeOffset = 0.0;

  final Widget child;
  final double edgeOffset;
  final RefreshCallback onRefresh;
  final ValueChanged<RefreshIndicatorStatus?>? onStatusChange;
  final ScrollNotificationPredicate notificationPredicate;

  @override
  CustomRefreshState createState() => CustomRefreshState();
}

class CustomRefreshState extends State<CustomRefresh>
    with TickerProviderStateMixin<CustomRefresh> {
  RefreshIndicatorStatus? _status;
  double? _dragOffset; //下拉的垂直距离
  final ValueNotifier<double> _counter = ValueNotifier<double>(0);

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final Duration _duration = const Duration(seconds: 2);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    ); // 循环播放

    // 2. 创建偏移量动画
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero, // 起始位置：中心点
      end: const Offset(-1, 1), // 终点位置：向左下移动 (坐标系比例)
    ).animate(
      _controller,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose(); // 释放资源
    super.dispose();
  }

  bool _shouldStart(ScrollNotification notification) {
    return (
            //必须是用户拖动的开始或更新事件
            (notification is ScrollStartNotification &&
                    notification.dragDetails != null) ||
                (notification is ScrollUpdateNotification &&
                    notification.dragDetails != null))
        //滚动方向向下且处于列表最顶部
        &&
        (notification.metrics.axisDirection == AxisDirection.down &&
            notification.metrics.extentBefore == 0.0)
        //当前没有刷新状态且可以启动刷新
        &&
        _status == null;
  }

  //return false  允许传播：通知会继续向上传递
  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) {
      return false;
    }
    if (_shouldStart(notification)) {
      _dragOffset = 0.0;
      _counter.value = _dragOffset ?? 0;
      setState(() {
        _status = RefreshIndicatorStatus.drag;
        widget.onStatusChange?.call(_status);
      });
      return false;
    }
    if (notification is ScrollUpdateNotification) {
      if (_status == RefreshIndicatorStatus.drag ||
          _status == RefreshIndicatorStatus.armed) {
        if (notification.metrics.axisDirection == AxisDirection.down) {
          _dragOffset =
              _dragOffset! - notification.scrollDelta!; //向下拖动时，scrollDelta 为负值
          _counter.value = _dragOffset ?? 0;
        }
        _checkDragOffset(
            notification.metrics.viewportDimension); //viewportDimension当前视口的高度
      }
      if (_status == RefreshIndicatorStatus.armed &&
          notification.dragDetails == null) {
        //在 iOS 上，当用户下拉超过阈值后释放，列表会先回弹到顶部，再触发刷新。
        //notification.dragDetails == null 表示当前没有活跃的拖动手势（即处于回弹阶段）
        _show();
      }
    } else if (notification is OverscrollNotification) {
      //用户下拉到列表顶部后继续拉动
      if (_status == RefreshIndicatorStatus.drag ||
          _status == RefreshIndicatorStatus.armed) {
        if (notification.metrics.axisDirection == AxisDirection.down) {
          _dragOffset = _dragOffset! - notification.overscroll;
          _counter.value = _dragOffset ?? 0;
        }
        _checkDragOffset(notification.metrics.viewportDimension);
      }
    } else if (notification is ScrollEndNotification) {
      logger.i('$_status,  $notification');
      switch (_status) {
        case RefreshIndicatorStatus.armed:
          // _dismiss(RefreshIndicatorStatus.canceled);
          _show();
        case RefreshIndicatorStatus.drag:
          _dismiss(RefreshIndicatorStatus.canceled);
        case RefreshIndicatorStatus.canceled:
        case RefreshIndicatorStatus.done:
        case RefreshIndicatorStatus.refresh:
        case RefreshIndicatorStatus.snap:
        case null:
          break;
      }
    }
    return false;
  }

  bool _handleIndicatorNotification(
      OverscrollIndicatorNotification notification) {
    if (notification.depth != 0 || !notification.leading) {
      return false;
    }
    if (_status == RefreshIndicatorStatus.drag) {
      //用户正在拖动
      notification.disallowIndicator(); // 禁用默认越界效果
      return true; //表示已处理通知，阻止系统默认行为
    }
    return false;
  }

  void _checkDragOffset(double containerExtent) {
    assert(_status == RefreshIndicatorStatus.drag ||
        _status == RefreshIndicatorStatus.armed);
    if (_status == RefreshIndicatorStatus.drag &&
        (_dragOffset! >= (containerExtent * _kDragContainerExtentPercentage))) {
      _status = RefreshIndicatorStatus.armed;
      widget.onStatusChange?.call(_status);
    }
  }

  Future<void> _dismiss(RefreshIndicatorStatus newMode) async {
    await Future<void>.value();
    assert(newMode == RefreshIndicatorStatus.canceled ||
        newMode == RefreshIndicatorStatus.done);
    setState(() {
      _status = newMode;
      widget.onStatusChange?.call(_status);
    });
    if (mounted && _status == newMode) {
      _dragOffset = null;
      _counter.value = _dragOffset ?? 0;
      setState(() {
        _status = null;
      });
    }
  }

  void _show() async {
    assert(_status != RefreshIndicatorStatus.refresh);
    assert(_status != RefreshIndicatorStatus.snap);
    _status = RefreshIndicatorStatus.snap;
    widget.onStatusChange?.call(_status);
    await Future.delayed(Duration(seconds: 3));
    _dismiss(RefreshIndicatorStatus.canceled);
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification, //跟踪滚动行为
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleIndicatorNotification, //滚动越界事件 下拉到顶部后继续下拉
        child: widget.child,
      ),
    );
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;
    return Stack(
      children: <Widget>[
        NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: ValueListenableBuilder<double>(
                    valueListenable: _counter,
                    builder: (context, value, child) {
                      final height =
                          _counter.value > 80.0 ? 80.0 : _counter.value;
                      return Container(
                        color: Colors.red,
                        height: height,
                        child: Stack(
                          children: [
                            if (height > 40)
                              Positioned(
                                left: centerX - _counter.value, // X轴向左移动
                                top: centerY + 40 + _counter.value,   // Y轴向下移动
                                child: SizedBox(
                                  width: 8,
                                  height: 8,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                        // child: height > 40
                        //     ? Positioned(
                        //         left: centerX - _counter.value, // X轴向左移动
                        //         top: centerY + 40 + _counter.value,   // Y轴向下移动
                        //         child: SizedBox(
                        //           width: 8,
                        //           height: 8,
                        //           child: Container(
                        //             decoration: const BoxDecoration(
                        //               color: Colors.blue,
                        //               shape: BoxShape.circle,
                        //             ),
                        //           ),
                        //         ),
                        //       )
                            // ? Align(
                            //     alignment: Alignment.topCenter,
                            //     child: AnimatedBuilder(
                            //       animation: _controller,
                            //       builder: (context, child) {
                            //         return Transform.translate(
                            //           offset: _offsetAnimation.value * 40,
                            //           // 将比例转换为实际偏移量
                            //           child: SizedBox(
                            //             width: 8,
                            //             height: 8,
                            //             child: Container(
                            //               decoration: const BoxDecoration(
                            //                 color: Colors.blue,
                            //                 shape: BoxShape.circle,
                            //               ),
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   )
                            // : const SizedBox.shrink(),
                      );
                    }),
              )
            ];
          },
          body: child,
        ),
      ],
    );
  }
}
