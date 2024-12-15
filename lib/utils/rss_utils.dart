

class RssUtils {

  static String? extractFirstImage(String htmlString) {
    if (htmlString.isEmpty) return null;

    final regex = RegExp(r'<img[^>]+src="([^">]+)"', caseSensitive: false);
    final match = regex.firstMatch(htmlString);
    return match != null ? match.group(1) : null;
  }

  static String cleanHtmlTags(String htmlString) {
    final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlString.replaceAll(regex, '').trim();
  }
}

