

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/core/utils/page_utils.dart';
import 'package:follow_read/features/domain/models/tile.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/tile_provider.dart';

// abstract class Fata {
//
// }
//
// abstract class IFata {
//
//   Fata get(WidgetRef ref);
// }
//
// class Feedx implements IFata {
//   final int id;
//   const Feedx(this.id);
//
//   @override
//   Fata get(WidgetRef ref) {
//     final data = ref.read(tileProvider(PageUtils.pid(TileType.feed, id)).future);
//
//     final tileAsync = ref.watch(tileProvider(pid));
//     data
//   }
//
// }