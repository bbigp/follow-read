

import 'package:flutter/cupertino.dart';
import 'package:follow_read/features/domain/models/ui_item.dart';

class Listx extends BaseUiItem {
  final String title;
  final String svgicon;
  final int unread;

  Listx({
    required this.title,
    required this.svgicon,
    this.unread = 0,
  });
}