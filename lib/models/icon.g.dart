// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedIcon _$FeedIconFromJson(Map<String, dynamic> json) => FeedIcon(
      feedId: (json['feed_id'] as num?)?.toInt() ?? 0,
      iconId: (json['icon_id'] as num?)?.toInt() ?? 0,
      mimeType: json['mime_type'] as String? ?? "",
      data: json['data'] as String? ?? "",
    );

Map<String, dynamic> _$FeedIconToJson(FeedIcon instance) => <String, dynamic>{
      'feed_id': instance.feedId,
      'icon_id': instance.iconId,
      'mime_type': instance.mimeType,
      'data': instance.data,
    };
