

import 'package:follow_read/features/data/datasources/cluster_dao.dart';
import 'package:follow_read/features/data/datasources/entities/cluster_entity.dart';
import 'package:follow_read/features/domain/models/cluster.dart';

class ClusterRepository {

  final ClusterDao dao;

  ClusterRepository({required this.dao});

  Future<List<Cluster>> getAll({bool? hideGlobally}) async {
    final list = await dao.getAll(hideGlobally: hideGlobally);
    return list.map((item) => item.toModel()).toList();
  }


  Future<Cluster> getById(int id) async {
    return (await dao.getById(id)).toModel();
  }

  Future<bool> updateShow(int id, {bool? onlyShowUnread, bool? showReadingTime,
    String? orderx, bool? hideGlobally, }) async {
    return await dao.updateShow(id, onlyShowUnread: onlyShowUnread,
      showReadingTime: showReadingTime,
      orderx: orderx,
      hideGlobally: hideGlobally,
    );
  }

}