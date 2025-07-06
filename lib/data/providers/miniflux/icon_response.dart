


import 'package:dart_mappable/dart_mappable.dart';


part 'icon_response.mapper.dart';

@MappableClass()
class IconResponse with IconResponseMappable {
  @MappableField(key: 'feed_id')
  final int feedId;
  @MappableField(key: 'icon_id')
  final int iconId;

  IconResponse({
    required this.feedId,
    required this.iconId,
  });
}
