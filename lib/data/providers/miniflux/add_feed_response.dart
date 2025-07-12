

import 'package:dart_mappable/dart_mappable.dart';

part 'add_feed_response.mapper.dart';

@MappableClass()
class AddFeedResponse with AddFeedResponseMappable{

  @MappableField(key: 'feed_id')
  final BigInt feedId;

  AddFeedResponse({
    required this.feedId
  });

}