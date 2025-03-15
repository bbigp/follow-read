import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.mapper.dart';
// @freezed
// class UserModel with _$UserModel {
//   const factory UserModel({
//     required int id,
//     required String username,
//     @JsonKey(name: "is_admin") required bool isAdmin,
//     @Default("light") String theme, // 默认值示例
//     @Default("") String language,
//     @Default("UTC") String timezone,
//     @JsonKey(name: "show_reading_time") @Default(false) bool showReadingTime,
//     @JsonKey(name: "last_login_at") @Default("") String lastLoginAt,
//   }) = _UserModel;
//
//   factory UserModel.fromJson(Map<String, dynamic> json) =>
//       _$UserModelFromJson(json);
// }

@MappableClass()
class UserModel with UserModelMappable {
    final int id;
    final String username;
    @MappableField(key: 'is_admin')
    final bool isAdmin;
    final String theme; // 默认值示例
    final String language;
    final String timezone;
    @MappableField(key: 'show_reading_time')
    final bool showReadingTime;
    @MappableField(key: 'last_login_at')
    final String lastLoginAt;

    UserModel({
      required this.id,
      required this.username,
      required this.isAdmin,
      required this.theme,
      required this.language,
      required this.timezone,
      required this.showReadingTime,
      required this.lastLoginAt,
    });

    UserEntity toEntity() => UserEntityMapper.fromMap(toMap());

}