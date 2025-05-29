

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:follow_read/features/data/repositories/cluster_repository.dart';
import 'package:follow_read/features/domain/models/aist.dart';

import 'app_container.dart';

//FutureProvider 一次性 数据不缓存
//AsyncNotifierProvider  数据缓存  Provider暴漏出去，Notifier数据控制器



final aistsProvider = AsyncNotifierProvider.autoDispose<AistsNotifier, List<Cluster>>(
  AistsNotifier.new
);

class AistsNotifier extends AutoDisposeAsyncNotifier<List<Cluster>> {
  late final ClusterRepository _clusterRepository = ref.watch(clusterRepositoryProvider);

  @override
  FutureOr<List<Cluster>> build() async {
    return await _clusterRepository.getAll();
  }
}




