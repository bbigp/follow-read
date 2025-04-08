

import 'package:follow_read/features/data/datasources/entities/category_entity.dart';

import '../../domain/models/category.dart';
import '../datasources/category_dao.dart';

class CategoryRepository {

  final CategoryDao dao;

  CategoryRepository({required this.dao});

  Future<List<Category>> getCategories() async {
    final list = await dao.getAll();
    return list.map((item) => item.toModel()).toList();
  }


  Future<Category> getCategoryById(int id) async {
    return (await dao.getCategoryById(id)).toModel();
  }

  Future<bool> updateShow(int id, {bool? onlyShowUnread, bool? showReadingTime,
    String? orderx}) async {
    return await dao.updateShow(id, onlyShowUnread: onlyShowUnread,
        showReadingTime: showReadingTime,
      orderx: orderx,
    );
  }

}