import 'package:follow_read/features/domain/models/ui_item.dart';

import 'constants.dart';
import 'feedx.dart';


class Feed implements MetaViewData {
  final int id;
  final int userId;
  final String feedUrl;
  final String siteUrl;
  @override
  final String title;
  @override
  final int unread;
  final int read;
  final String iconUrl;
  final bool onlyShowUnread;
  final bool showReadingTime;
  final int errorCount;
  final String errorMsg;
  final int categoryId;
  final String order;
  final bool hideGlobally;

  const Feed({
    required this.id,
    required this.userId,
    required this.feedUrl,
    required this.siteUrl,
    required this.title,
    this.unread = 0,
    this.read = 0 ,
    this.iconUrl = "",
    this.onlyShowUnread = false,
    this.showReadingTime = false,
    this.errorCount = 0,
    this.errorMsg = "",
    this.categoryId = 0,
    this.order = Frc.orderxPublishedAt,
    this.hideGlobally = false,
  });

  Feed copyWith({
    int? id,
    int? userId,
    String? feedUrl,
    String? siteUrl,
    String? title,
    int? unread,
    int? read,
    String? iconUrl,
    bool? onlyShowUnread,
    bool? showReadingTime,
    int? errorCount,
    String? errorMsg,
    int? categoryId,
    String? order,
    bool? hideGlobally,
  }) {
    return Feed(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedUrl: feedUrl ?? this.feedUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      title: title ?? this.title,
      unread: unread ?? this.unread,
      read: read ?? this.read,
      iconUrl: iconUrl ?? this.iconUrl,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
        showReadingTime: showReadingTime ?? this.showReadingTime,
      errorCount: errorCount ?? this.errorCount,
      errorMsg: errorMsg ?? this.errorMsg,
        categoryId: categoryId ?? this.categoryId,
      order: order ?? this.order,
        hideGlobally: hideGlobally ?? this.hideGlobally,
    );
  }

  static Feed empty = Feed(id: 0, userId: 0, feedUrl: "", siteUrl: "", title: "");

  SQLQueryBuilder toBuilder(){
    return SQLQueryBuilder(page: 1, pageSize: 10,
      feedIds: [id],
      statuses: onlyShowUnread ? ["unread"] : ["unread", "read"],
      order: order,
    );
  }


}

class SQLQueryBuilder {
  final List<int>? feedIds;
  final List<String>? statuses;
  final DateTime? minPublishedTime;
  final DateTime? minAddTime;
  final bool? starred;
  final int page;
  final int pageSize;
  final String? order;

  const SQLQueryBuilder({
    this.feedIds,
    this.statuses,
    this.minPublishedTime,
    this.minAddTime,
    this.starred,
    required this.page,
    required this.pageSize,
    this.order,
  });
}

