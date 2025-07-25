

import 'package:dart_mappable/dart_mappable.dart';

import 'feed_response.dart';
import 'media.dart';

part 'entry_page_response.mapper.dart';

@MappableClass()
class EntryPageResponse with EntryPageResponseMappable {
  final int total;
  final List<EntryResponse> entries;

  EntryPageResponse({required this.total, required this.entries});

}

@MappableClass()
class EntryResponse with EntryResponseMappable{
  final BigInt id;
  @MappableField(key: 'user_id')
  final BigInt userId;
  @MappableField(key: 'feed_id')
  final BigInt feedId;
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
  final String? content;
  final String? author;
  @MappableField(key: 'share_code')
  final String? shareCode;
  final bool starred;
  @MappableField(key: 'reading_time')
  final int readingTime;
  final List<MediaResponse>? enclosures;
  final FeedResponse? feed;
  // final dynamic tags;

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
    this.enclosures,
    required this.feed,
    // required this.tags,
  });

}