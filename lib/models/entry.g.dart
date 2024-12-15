// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      feedId: (json['feed_id'] as num).toInt(),
      status: json['status'] as String,
      hash: json['hash'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      commentsUrl: json['comments_url'] as String?,
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      changedAt: DateTime.parse(json['changed_at'] as String),
      content: json['content'] as String?,
      author: json['author'] as String?,
      shareCode: json['share_code'] as String?,
      starred: json['starred'] as bool,
      readingTime: (json['reading_time'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mainPic: Entry._readMainPic(json, 'mainPic') == null
          ? ""
          : Entry._mainPicFromJson(
              Entry._readMainPic(json, 'mainPic') as String?),
      summary: Entry._readMainPic(json, 'summary') == null
          ? ""
          : Entry._summaryFromJson(
              Entry._readMainPic(json, 'summary') as String?),
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'feed_id': instance.feedId,
      'status': instance.status,
      'hash': instance.hash,
      'title': instance.title,
      'url': instance.url,
      'mainPic': instance.mainPic,
      'summary': instance.summary,
      'comments_url': instance.commentsUrl,
      'published_at': instance.publishedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'changed_at': instance.changedAt.toIso8601String(),
      'content': instance.content,
      'author': instance.author,
      'share_code': instance.shareCode,
      'starred': instance.starred,
      'reading_time': instance.readingTime,
      'tags': instance.tags,
    };

EntryResponse _$EntryResponseFromJson(Map<String, dynamic> json) =>
    EntryResponse(
      total: (json['total'] as num).toInt(),
      entries: (json['entries'] as List<dynamic>)
          .map((e) => Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EntryResponseToJson(EntryResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'entries': instance.entries,
    };
