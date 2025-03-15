import 'package:intl/intl.dart';


class RssUtils {

  static String? extractFirstImage(String htmlString) {
    if (htmlString.isEmpty) return null;

    final regex = RegExp(r'<img[^>]+src="([^">]+)"', caseSensitive: false);
    final match = regex.firstMatch(htmlString);
    return match?.group(1);
  }

  static String cleanHtmlTags(String htmlString) {
    final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlString.replaceAll(regex, '').trim();
  }

  static String timeAgo(DateTime targetTime) {
    final now = DateTime.now();
    final difference = now.difference(targetTime);

    if (difference.inMinutes < 60) {
      // 1小时内，显示为多少分钟之前
      return '${difference.inMinutes} 分钟之前';
    } else if (difference.inHours < 24) {
      // 24小时内，显示为多少小时之前
      return '${difference.inHours} 小时之前';
    } else {
      // 超过24小时，显示为几月几号 几小时几分
      final formattedDate = DateFormat('MM月dd日 HH:mm').format(targetTime);
      return formattedDate;
    }
  }
}

