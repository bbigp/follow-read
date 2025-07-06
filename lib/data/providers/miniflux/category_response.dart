



import 'package:dart_mappable/dart_mappable.dart';

part 'category_response.mapper.dart';

@MappableClass()
class CategoryResponse with CategoryResponseMappable {
  final int id;
  final String title;
  @MappableField(key: 'user_id')
  final int userId;
  @MappableField(key: 'hide_globally')
  final bool? hideGlobally;
  // 根据实际数据结构补充字段
  CategoryResponse({
    required this.id,
    required this.title,
    required this.userId,
    this.hideGlobally,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryResponse &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}