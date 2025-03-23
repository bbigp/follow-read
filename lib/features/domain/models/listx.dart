

import 'package:flutter/cupertino.dart';
import 'package:follow_read/features/domain/models/ui_item.dart';

class Listx extends BaseUiItem {
  final String title;
  final IconData iconData;
  final int unread;

  Listx({
    required this.title,
    required this.iconData,
    this.unread = 0,
  });
}