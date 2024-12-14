

import 'package:json_annotation/json_annotation.dart';

part 'icon.g.dart';

@JsonSerializable()
class FeedIcon {
  @JsonKey(name: 'feed_id')
  final int feedId;
  @JsonKey(name: 'icon_id')
  final int iconId;
  @JsonKey(name: 'mime_type')
  final String mimeType;
  @JsonKey(name: 'data')
  final String data;

  FeedIcon({
    this.feedId = 0,
    this.iconId = 0,
    this.mimeType = "",
    this.data = "",
  });

  factory FeedIcon.fromJson(Map<String, dynamic> json) => _$FeedIconFromJson(json);

  Map<String, dynamic> toJson() => _$FeedIconToJson(this);

}