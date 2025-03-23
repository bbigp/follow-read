

import 'package:dart_mappable/dart_mappable.dart';
import 'package:drift/drift.dart';
import 'package:follow_read/features/data/datasources/database.dart';
import 'package:follow_read/features/data/models/feed_response.dart';

part 'entry_page_response.mapper.dart';

@MappableClass()
class EntryPageResponse with EntryPageResponseMappable {
  final int total;
  final List<EntryResponse> entries;

  EntryPageResponse({required this.total, required this.entries});

}

@MappableClass()
class EntryResponse with EntryResponseMappable{
  final int id;
  @MappableField(key: 'user_id')
  final int userId;
  @MappableField(key: 'feed_id')
  final int feedId;
  final String status;
  final String hash;
  final String title;
  final String url;
  @MappableField(key: 'comments_url')
  final String? commentsUrl;
  @MappableField(key: 'published_at')
  final DateTime publishedAt;
  @MappableField(key: 'created_at')
  final DateTime createdAt;
  @MappableField(key: 'changed_at')
  final DateTime changedAt;
  final String content;
  final String author;
  @MappableField(key: 'share_code')
  final String shareCode;
  final bool starred;
  @MappableField(key: 'reading_time')
  final int readingTime;
  // final List<dynamic>? enclosures;
  final FeedResponse feed;
  // final dynamic tags; // 根据实际类型可替换为具体类型

  EntryResponse({
    required this.id,
    required this.userId,
    required this.feedId,
    required this.status,
    required this.hash,
    required this.title,
    required this.url,
    required this.commentsUrl,
    required this.publishedAt,
    required this.createdAt,
    required this.changedAt,
    required this.content,
    required this.author,
    required this.shareCode,
    required this.starred,
    required this.readingTime,
    // required this.enclosures,
    required this.feed,
    // required this.tags,
  });

}

extension EntryResponseConversion on EntryResponse {
  EntriesTableCompanion toCompanion() {
    return EntriesTableCompanion.insert(
      id: Value(BigInt.from(id)),
      title: title,
      hash: hash,
      userId: BigInt.from(userId),
      feedId: BigInt.from(feedId),
      status: Value(status),
      url: url,
      publishedAt: Value(publishedAt),
      content: Value(content),
      author: Value(author),
      starred: Value(starred),
      readingTime: Value(readingTime),
      summary: Value(""),
    );
  }

  // Entry toModel() {
  //   return Entry(
  //     id: id,
  //     userId: userId,
  //     feedId: feedId,
  //     title: title,
  //     hash: hash,
  //     status: status,
  //     url: url,
  //     publishedAt: publishedAt,
  //     content: content,
  //     author: author,
  //     starred: starred,
  //     readingTime: readingTime,
  //     feed: feed.toModel(),
  //   );
  // }
}