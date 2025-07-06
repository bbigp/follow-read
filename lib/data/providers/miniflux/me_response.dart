

import 'package:dart_mappable/dart_mappable.dart';

part 'me_response.mapper.dart';

@MappableClass()
class MeResponse with MeResponseMappable {
  final int id;
  final String username;

  MeResponse({
    required this.id,
    required this.username,
  });

}