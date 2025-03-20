//
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../../core/utils/rss_utils.dart';
//
// part 'entry.g.dart';
//
// @JsonSerializable()
// class Entry {
//   final int id;
//   @JsonKey(name: 'user_id')
//   final int userId;
//   @JsonKey(name: 'feed_id')
//   final int feedId;
//   final String status;
//   final String hash;
//   final String title;
//   final String url;
//   @JsonKey(fromJson: _mainPicFromJson, readValue: _readMainPic)
//   final String? mainPic;
//   @JsonKey(fromJson: _summaryFromJson, readValue: _readMainPic)
//   final String summary;
//   @JsonKey(name: 'comments_url')
//   final String? commentsUrl;
//   @JsonKey(name: 'published_at')
//   final DateTime? publishedAt;
//   @JsonKey(name: 'created_at')
//   final DateTime createdAt;
//   @JsonKey(name: 'changed_at')
//   final DateTime changedAt;
//   final String? content;
//   final String? author;
//   @JsonKey(name: 'share_code')
//   final String? shareCode;
//   final bool starred;
//   @JsonKey(name: 'reading_time')
//   final int readingTime;
//   // final List<String> enclosures;
//   final List<String>? tags;
//
//   Entry({
//     required this.id,
//     required this.userId,
//     required this.feedId,
//     required this.status,
//     required this.hash,
//     required this.title,
//     required this.url,
//     this.commentsUrl,
//     this.publishedAt,
//     required this.createdAt,
//     required this.changedAt,
//     this.content,
//     this.author,
//     this.shareCode,
//     required this.starred,
//     required this.readingTime,
//     // required this.enclosures,
//     this.tags,
//     this.mainPic = "",
//     this.summary = "",
//   });
//
//   static dynamic _readMainPic(Map map, String fieldName) {
//     return map['content'];
//   }
//
//   static String? _mainPicFromJson(String? content){
//     if (content == null) {
//       return null;
//     }
//     return RssUtils.extractFirstImage(content);
//   }
//
//   static String _summaryFromJson(String? content) {
//     if (content == null) {
//       return "";
//     }
//     return RssUtils.cleanHtmlTags(content);
//   }
//
//   factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
//
//   Map<String, dynamic> toJson() => _$EntryToJson(this);
//
// }
//
// @JsonSerializable()
// class EntryResponse {
//   final int total;
//   final List<Entry> entries;
//
//   EntryResponse({
//     required this.total,
//     required this.entries,
//   });
//
//   factory EntryResponse.fromJson(Map<String, dynamic> json) => _$EntryResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$EntryResponseToJson(this);
//
// }
