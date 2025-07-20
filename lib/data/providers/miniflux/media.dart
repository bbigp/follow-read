

import 'package:dart_mappable/dart_mappable.dart';

part 'media.mapper.dart';

@MappableClass()
class MediaResponse with MediaResponseMappable{
  final BigInt id;
  @MappableField(key: 'user_id')
  final BigInt userId;
  @MappableField(key: 'entry_id')
  final BigInt entryId;
  final String url;
  @MappableField(key: 'mime_type')
  final String mimeType;
  final int size;
  @MappableField(key: 'media_progression')
  final int mediaProgression;

  MediaResponse({
    required this.id,
    required this.userId,
    required this.entryId,
    required this.url,
    required this.mimeType,
    required this.size,
    required this.mediaProgression,
  });
}