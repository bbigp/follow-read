

import 'package:flutter/material.dart';
import 'package:follow_read/core/svg_icons.dart';
import 'package:follow_read/data/providers/miniflux/feed_response.dart';
import 'package:follow_read/data/repositories/app_database.dart';
import 'package:follow_read/global/widgets/context_menu.dart';
import 'package:follow_read/modules/widgets/context_menu_wrapper.dart';
import 'package:follow_read/routes.dart';
import 'package:get/get.dart';

import 'constant.dart';
import 'entry.dart';
import 'meta.dart';

class Feed implements Meta {

  final BigInt id;
  final BigInt userId;
  final String feedUrl;
  @override
  final String siteUrl;
  @override
  final String title;
  final int errorCount;
  final String errorMsg;
  final BigInt folderId;
  final String desc;

  @override
  final bool hideGlobally;
  @override
  final bool onlyShowUnread;
  @override
  final String order;
  final String iconUrl;

  @override
  String get metaId => "e$id";

  @override
  String get url => feedUrl;

  // final int unread;
  // final int read;

  static Feed empty = Feed();

  Feed({
    BigInt? id,
    BigInt? userId,
    this.feedUrl = "",
    this.siteUrl = "",
    this.title = "",
    // this.unread = 0,
    // this.read = 0 ,
    this.iconUrl = "",
    this.desc = "",
    this.onlyShowUnread = false,
    this.errorCount = 0,
    this.errorMsg = "",
    BigInt? folderId,
    this.order = Model.orderPublishedAt,
    this.hideGlobally = false,
  }) :  id = id ?? BigInt.zero,
        userId = userId ?? BigInt.zero,
        folderId = folderId ?? BigInt.zero;

  List<String> get statuses => onlyShowUnread
      ? [EntryStatus.unread.name]
      : [EntryStatus.unread.name, EntryStatus.read.name];

  Feed copyWith({
    BigInt? id,
    BigInt? userId,
    String? feedUrl,
    String? siteUrl,
    String? title,
    // int? unread,
    // int? read,
    String? iconUrl,
    String? desc,
    bool? onlyShowUnread,
    bool? showReadingTime,
    int? errorCount,
    String? errorMsg,
    BigInt? folderId,
    String? order,
    bool? hideGlobally,
  }) {
    return Feed(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      feedUrl: feedUrl ?? this.feedUrl,
      siteUrl: siteUrl ?? this.siteUrl,
      title: title ?? this.title,
      // unread: unread ?? this.unread,
      // read: read ?? this.read,
      iconUrl: iconUrl ?? this.iconUrl,
      desc: desc ?? this.desc,
      onlyShowUnread: onlyShowUnread ?? this.onlyShowUnread,
      errorCount: errorCount ?? this.errorCount,
      errorMsg: errorMsg ?? this.errorMsg,
      folderId: folderId ?? this.folderId,
      order: order ?? this.order,
      hideGlobally: hideGlobally ?? this.hideGlobally,
    );
  }

  List<ContextMenuEntry> contextMenus(BuildContext context) => [
    ContextMenu(
        label: '编辑',
        icon: SvgIcons.edit,
        onTap: () => Get.toNamed(RouteConfig.addFeed, arguments: this)
        //     Open.modal(context, GetModalWrapper(
        //   initControllers: () {
        //     Get.put(AddFeedController(id: id));
        //   },
        //   disposeControllers: () => Get.delete<AddFeedController>(),
        //   builder: () => AddFeedForm(),
        // ))
    ),
    const ContextMenuDivider(),
    ContextMenu(
        label: "取消订阅",
        icon: SvgIcons.reduce_o,
        type: ContextMenuType.danger,
        onTap: () {
          // OpenModal.open(context, AlertSheet(
          //   title: "确认取消订阅?",
          //   msg: "该订阅将从所有文件夹和列表中删除",
          //   onPressed: () async {
          //     var success = await ref.read(feedRepositoryProvider).removeFeed(feed.id);
          //     if (success) {
          //       // final _ = ref.refresh(homeProvider);
          //       Navigator.of(context).pop();
          //     }
          //   },
          // ), hasMargin: true);
        }),
  ];

}

extension FeedRowExtension on FeedRow {
  Feed toFeed() {
    return Feed(
      id: id, userId: userId, feedUrl: feedUrl, siteUrl: siteUrl,
      title: title, iconUrl: iconUrl, onlyShowUnread: onlyShowUnread,
      errorMsg: errorMsg, errorCount: errorCount, folderId: folderId,
      order: orderx, hideGlobally: hideGlobally, desc: "",
    );
  }
}

extension FeedResponseExtension on FeedResponse {
  Feed toFeed(){
    return Feed(
      id: id, userId: userId, feedUrl: feedUrl, siteUrl: siteUrl,
      errorMsg: parsingErrorMessage, errorCount: parsingErrorCount,
      folderId: category?.id, title: title,
      hideGlobally: hideGlobally ?? false,

      onlyShowUnread: false,
      order: Model.orderPublishedAt,
      iconUrl: icon == null ? "" : "icons/${icon?.iconId}",
      desc: "",
    );
  }
}