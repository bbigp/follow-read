

import 'package:flutter/material.dart';
import 'package:follow_read/features/presentation/widgets/context_menu_wrapper.dart';
import 'package:follow_read/features/presentation/widgets/home/count_badge.dart';

abstract class TileDataProvider {
  String get title;
  Widget get leadingIndicator;
  Widget get icon;
  Counter get counter;
  int get id;
  List<ContextMenuEntry> get contextMenus;
  GestureTapCallback? get onTap;
}