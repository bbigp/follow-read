

import 'package:follow_read/data/providers/miniflux/me_response.dart';

class User {

  final int id;
  final String username;
  final String token;
  final String baseUrl;
  final bool autoRead;
  final UnreadMark unreadMark;
  final String openContent;

  User({
    required this.id,
    required this.username,
    required this.token,
    required this.baseUrl,
    this.autoRead = true,
    this.unreadMark = UnreadMark.dot,
    this.openContent = "内置阅读器",
  });

  static User empty = User(id: 0, username: "", token: "", baseUrl: "");

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