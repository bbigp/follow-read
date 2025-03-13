
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String title;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'hide_globally')
  final bool hideGlobally;

  Category({
    this.id = 0,
    this.title = "",
    this.userId = 0,
    this.hideGlobally = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

}