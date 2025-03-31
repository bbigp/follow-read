
import 'package:flutter/material.dart';

import '../../../core/utils/logger.dart';
import 'bsbs.dart';

class Custom extends StatefulWidget {
  final Widget child;
  const Custom({super.key,
    required this.child,
  });

  @override
  CustomState createState() => CustomState();
}

enum CustomStatus {
  init,
  drag, //用户开始下拉但未达触发阈值
  armed, //下拉距离达到或超过触发阈值
  snap, //用户释放手指后，准备执行刷新前的动画
  refresh, //正式执行刷新操作
  done, //刷新成功完成
  canceled, //刷新被中止（如中途滑动取消）
}

class CustomState extends State<Custom> with TickerProviderStateMixin<Custom> {

  late CustomStatus status = CustomStatus.init;

  double _dragOffset = 0; //下拉的垂直距离
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.axisDirection == AxisDirection.down) {
        _dragOffset = _dragOffset - notification.scrollDelta!;
        logger.i('down $_dragOffset ${notification.scrollDelta}');
      } else if (notification.metrics.axisDirection == AxisDirection.up) {
        _dragOffset = _dragOffset + notification.scrollDelta!;
        logger.i('up $_dragOffset ${notification.scrollDelta}');
      }
      _checkDragOffset(notification.metrics.viewportDimension);
    } else if (notification is OverscrollNotification) {
      if (notification.metrics.axisDirection == AxisDirection.down) {
        _dragOffset = _dragOffset - notification.overscroll;
      } else if (notification.metrics.axisDirection == AxisDirection.up) {
        _dragOffset = _dragOffset + notification.overscroll;
      }
      _checkDragOffset(notification.metrics.viewportDimension);
        // logger.i('$_dragOffset ${notification.overscroll}');
    } else if (notification is ScrollEndNotification) {
      if (status == CustomStatus.drag) {
        status = CustomStatus.init;
      }
    }
    if (status == CustomStatus.init) {
      _dragOffset = 0;
    } else {
      _dragOffset = _dragOffset.clamp(0.0, 80.0);
    }
    setState(() {});
    return false;
  }

  void _checkDragOffset(double containerExtent) {
    if (status == RefreshIndicatorStatus.drag && (_dragOffset >= (containerExtent * 0.1))) {
      status = CustomStatus.armed;
    } else {
      status = CustomStatus.drag;
    }
  }

  bool _handleIndicatorNotification(OverscrollIndicatorNotification notification) {
    notification.disallowIndicator(); // 禁用默认越界效果
    return true; //表示已处理通知，阻止系统默认行为
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
    return Stack(
      children: [
        NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            final height = _dragOffset > 80.0 ? 80.0 : _dragOffset;
            return [
              SliverToBoxAdapter(
                child: Container(height: height, color: Colors.blue,),
              ),
            ];
          },
          body: child,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container( // 添加容器约束
            height: _dragOffset, // 与 BouncyBalls 高度一致
            color: Colors.amber,
            alignment: Alignment.center,
            child: BouncyBalls(offset: _dragOffset),
          ),
        ),
        Positioned(
          top: 30,
          left: 20,
          child: Text('$_dragOffset'),
        ),
      ],
    );
  }

}




class My extends StatelessWidget {
  const My({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('下拉移动示例')),
        body: Custom(
          child: ListView(
            children: List.generate(
              20, (index) => ListTile(title: Text('列表项 $index')),
            ),
          ),
        ),
      ),
    );
  }
}