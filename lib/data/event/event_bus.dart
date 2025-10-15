

import 'dart:async';

import 'package:follow_read/data/event/app_event.dart';
import 'package:get/get.dart';

class GlobalEventBus {

  // 使用 StreamController，设置 .broadcast() 允许多个订阅者
  final _controller = StreamController<AppEvent>.broadcast();

  // 发布事件：将事件对象加入到 Stream 中
  void fire(AppEvent event) {
    if (!_controller.isClosed) {
      _controller.sink.add(event);
    }
  }

  // 监听特定类型事件：使用 where 和 cast 过滤流
  Stream<T> on<T extends AppEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  void dispose() {
    _controller.close();
  }

}

class EventBusService extends GetxService {
  final GlobalEventBus bus = GlobalEventBus();

  @override
  void onClose() {
    bus.dispose();
    super.onClose();
  }
}