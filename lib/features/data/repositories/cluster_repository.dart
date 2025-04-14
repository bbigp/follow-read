

import 'package:follow_read/features/data/datasources/cluster_dao.dart';
import 'package:follow_read/features/data/datasources/entities/cluster_entity.dart';
import 'package:follow_read/features/domain/models/cluster.dart';

class ClusterRepository {

  final ClusterDao dao;

  ClusterRepository({required this.dao});

  Future<List<Cluster>> getAll() async {
    final list = await dao.getAll();
    return list.map((item) => item.toModel()).toList();
  }


  Future<Cluster> getById(int id) async {
    return (await dao.getById(id)).toModel();
  }

}