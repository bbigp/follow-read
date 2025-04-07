

import 'package:follow_read/features/domain/models/ui_item.dart';

import '../../../config/svgicons.dart';

class Listx extends BaseUiItem {

  static final int all = 1;
  static final int read = 2;
  static final int unread = 3;
  static final int starred = 4;
  static final int today = 5;

  static final Listx allListx = Listx(id: Listx.all, title: '全部', svgicon: Svgicons.all,);
  static final Listx readListx = Listx(id: Listx.read, title: '近期已读', svgicon: Svgicons.markRead,);
  static final Listx starredListx = Listx(id: Listx.starred, title: '星标', svgicon: Svgicons.addCollection,);
  static final Listx unreadListx = Listx(id: Listx.unread, title: '未读', svgicon: Svgicons.markUnread,);
  static final Listx todayListx = Listx(id: Listx.today, title: '今日', svgicon: Svgicons.today,);

  static final pageAll = [allListx, readListx, starredListx, unreadListx, todayListx];

  final int id;
  final String title;
  final String svgicon;
  final int count;

  const Listx({
    required this.id,
    required this.title,
    required this.svgicon,
    this.count = 0,
  });

  Listx copyWith({
    int? id,
    String? title,
    String? svgicon,
   int? count,
  }) {
    return Listx(id: id ?? this.id, title: title ?? this.title, svgicon: svgicon ?? this.svgicon, count: count ?? this.count);
  }
}