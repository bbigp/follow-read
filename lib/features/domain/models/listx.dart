

import 'package:follow_read/features/domain/models/ui_item.dart';

class Listx extends BaseUiItem {

  static final int all = -1;
  static final int read = -2;
  static final int unread = -3;
  static final int starred = -4;
  static final int today = -5;

  final int id;
  final String title;
  final String svgicon;
  final int count;

  Listx({
    required this.id,
    required this.title,
    required this.svgicon,
    this.count = 0,
  });
}