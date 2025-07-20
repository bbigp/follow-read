

import 'package:follow_read/data/providers/miniflux/me_response.dart';

// ignore_for_file: constant_identifier_names
class User {

  static final String OPEN_CONTENT_VIEW = "内置阅读器";
  static final String OPEN_CONTENT_WEBVIEW = "应用内浏览器";
  static final String OPEN_CONTENT_BROWSER = "系统浏览器";

  final int id;
  final String username;
  final String token;
  final String baseUrl;
  final bool autoRead;
  final UnreadMark unreadMark;
  final String openContent;
  final BigInt rootFolderId;

  User({
    required this.id,
    required this.username,
    required this.token,
    required this.baseUrl,
    this.autoRead = true,
    this.unreadMark = UnreadMark.dot,
    this.openContent = "内置阅读器",
    BigInt? rootFolderId,
  }): rootFolderId = rootFolderId ?? BigInt.zero;

  static User empty = User(id: 0, username: "", token: "", baseUrl: "");

  bool get isNull => id == 0;
}

enum UnreadMark {
  none, dot, number;

  static UnreadMark fromString(String value) {
    switch (value) {
      case 'Dot':
        return UnreadMark.dot;
      case 'Number':
        return UnreadMark.number;
      case 'None':
      default:
        return UnreadMark.none;
    }
  }

  String get asString => name[0].toUpperCase() + name.substring(1);
}


extension MeResponseExtension on MeResponse {

  User toUser({required String token, required String baseUrl}){
    return User(
      id: id,
      username: username,
      token: token,
      baseUrl: baseUrl,
    );

  }

}