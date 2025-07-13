


import 'package:follow_read/data/model/feed.dart';
import 'package:follow_read/data/providers/miniflux/category_response.dart';
import 'package:follow_read/data/repositories/app_database.dart';

import 'entry.dart';
import 'meta.dart';

class Folder implements Meta {
  final BigInt id;
  final BigInt userId;
  final String title;
  final bool hideGlobally;
  final String order;
  final bool onlyShowUnread;

  final bool expanded;
  final List<Feed> feeds;

  Folder({
    BigInt? id, BigInt? userId,
    this.title = "",
    this.hideGlobally = false,
    this.onlyShowUnread = false,
    this.order = "publishedTime",

    this.expanded = false,
    this.feeds = const [],
  }) :  id = id ?? BigInt.zero,
        userId = userId ?? BigInt.zero;

  Folder copyWith({
    BigInt? id,
    BigInt? userId,
    String? title,
    bool? hideGlobally,
    bool? onlyShowUnread,
    String? order,

    List<Feed>? feeds,
    bool? expanded,
  }) {
    return Folder(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      hideGlobally: hideGlobally ?? this.hideGlobally,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      order: order ?? this.order,

      feeds: feeds ?? this.feeds,
      expanded: expanded ?? this.expanded,
    );
  }

  List<String> get statuses => onlyShowUnread
      ? [EntryState.unread.name]
      : [EntryState.unread.name, EntryState.read.name];

  static Folder empty = Folder();
}

extension FolderRowExtension on FolderRow {
  Folder toFolder() {
    return Folder(
      id: id, userId: userId,
      title: title, hideGlobally: hideGlobally,
    );
  }
}


extension CategoryResponseExtension on CategoryResponse {
  Folder toFolder(){
    return Folder(
      id: id, userId: userId, title: title, hideGlobally: hideGlobally ?? false,
    );
  }
}