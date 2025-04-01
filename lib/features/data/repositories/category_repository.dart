

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

}