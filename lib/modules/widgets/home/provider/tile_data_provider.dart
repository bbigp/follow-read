

import 'package:flutter/material.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';

abstract class TileDataProvider {
  String get title;
  //这里正常来说返回一个Widget就行，但是点击区域有点小，需要扩大点击范围，
  // 所以传入widget和onTap,构建的时候重新组合
  WidgetxBuilder get leadingIndicator;
  Widget get icon;
  int get id;
  List<ContextMenuEntry> get contextMenus;
  GestureTapCallback? get onTap;
}

class WidgetxBuilder {
  final Widget widget;
  final GestureTapCallback? onTap;
  const WidgetxBuilder(this.widget, {this.onTap});
}