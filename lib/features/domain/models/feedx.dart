

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';

final mataDetailProvider = FutureProvider.family.autoDispose<Mata, IMata>((ref, mata) {
  return mata.load(ref);
});

abstract class Mata {
}


abstract class IMata {

  Future<Mata> load(Ref ref);

  Future<void> update(Ref ref);
}

class Feedx implements IMata {
  
  final int id;
  const Feedx(this.id);
  
  @override
  Future<Mata> load(Ref ref) {
    return ref.read(feedRepositoryProvider).getFeedById(id);
  }
  @override
  Future<void> update(Ref ref) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

// class Folderx implements IMata {
//   @override
//   Future<Mata> load(WidgetRef ref) {
//     return Folder();
//   }
//   @override
//   Future<void> update(WidgetRef ref) {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
// }
