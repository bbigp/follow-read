

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/domain/models/feed.dart';
import 'package:follow_read/features/presentation/providers/app_container.dart';
import 'package:follow_read/features/presentation/providers/feeds_provider.dart';

final mataProvider = FutureProvider.family.autoDispose<Mata, IMata>((ref, mata) {
  return mata.load(ref);
});

abstract class Mata {
  String get title;
  int get unread;
}

abstract class IMata {

  Mata load(WidgetRef ref);

  Future<void> update(Ref ref);
}

class Feedx implements IMata {
  
  final int id;
  const Feedx(this.id);
  
  @override
  Mata load(WidgetRef ref) {
    ref.watch(provider());
    return ref.read(feedsProvider.notifier).get(id);
  }
  AsyncValue<Feed?> load1(WidgetRef ref) {
    return ref.watch(provider());
  }
  @override
  Future<void> update(Ref ref) {
    // TODO: implement update
    throw UnimplementedError();
  }

  AutoDisposeProvider<AsyncValue<Feed?>> provider() {
    return AutoDisposeProvider<AsyncValue<Feed?>>((ref) {
      return AsyncData(null);
    });
  }
}

// final folderAsync = ref.watch(folderProvider);
//
// return folderAsync.when(
// data: (folderItem) {
// if (folderItem == null) {
// return Text("Folder not found");
// }
// // folderItem 就是你当前的 Folder
// return Text("Folder title: ${folderItem.title}");
// },
// loading: () => CircularProgressIndicator(),
// error: (err, stack) => Text("Error: $err"),
// );

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
