

import '../../features/domain/models/tile.dart';

class PageUtils {

  const PageUtils._();

  static String pid(TileType type, int id){
    return '$type-$id';
  }


  static PageId parsePid(String id) {
    final parts = id.split('-');
    if (parts.length != 2) {
      throw FormatException('Invalid ID format: $id');
    }
    return PageId(type: TileType.fromString(parts[0]), id: int.parse(parts[1]));
  }



}

class PageId {
  final TileType type;
  final int id;

  const PageId({required this.type, required this.id});
}