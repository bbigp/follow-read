//
//
// import 'package:follow_read/features/data/datasources/entities/category_entity.dart';
//
// import '../../domain/models/folder.dart';
// import '../datasources/category_dao.dart';
//
// class CategoryRepository {
//
//   final CategoryDao dao;
//
//   CategoryRepository({required this.dao});
//
//   Future<List<Category>> getCategories({bool showAll = true}) async {
//     final list = await dao.getAll(showAll: showAll);
//     return list.map((item) => item.toModel()).toList();
//   }
//
//
//   Future<Category> getCategoryById(int id) async {
//     return (await dao.getCategoryById(id)).toModel();
//   }
//
//   Future<Category> getByName(String name) async {
//     return (await dao.getByName(name)).toModel();
//   }
//
//   Future<bool> updateShow(int id, {bool? onlyShowUnread, bool? showReadingTime,
//     String? orderx, bool? hideGlobally, }) async {
//     return await dao.updateShow(id, onlyShowUnread: onlyShowUnread,
//         showReadingTime: showReadingTime,
//       orderx: orderx,
//       hideGlobally: hideGlobally,
//     );
//   }
//
// }