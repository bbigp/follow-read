

class Model {

  const Model._();

  static const String orderPublishedAt = "publishedAt";
  static const String orderCreatedAt = "createdAt";

  static const String folder = "folder";
  static const String feed = "feed";
  static const String artiad = "artiads";

  static const String unread = "unread";
  static const String read = "read";

  static const String rootFolderName = "All";

}

extension DateTimeConversion on DateTime{

  String toShowTime() {
    final now = DateTime.now();
    final difference = now.difference(this);
    final units = [
      (value: difference.inDays, unit: "天"),
      (value: difference.inHours % 24, unit: "小时"),
      (value: difference.inMinutes % 60, unit: "分钟"),
    ];

    for (var u in units) {
      if (u.value > 0) {
        return "${u.value}${u.unit}前";
      }
    }
    return "刚刚";
  }
}

extension DateTimeStringExtension on String {

  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } on FormatException {
      return null;
    }
  }
}