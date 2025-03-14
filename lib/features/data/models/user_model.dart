
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entry.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String username;
  @JsonKey(name: "is_admin")
  final bool isAdmin;
  final String theme;
  final String language;
  final String timezone;
  @JsonKey(name: "show_reading_time")
  final bool showReadingTime;
  @JsonKey(name: "last_login_at")
  final String lastLoginAt;
  String token;

  UserModel({
    required this.id,
    required this.username,
    required this.isAdmin,
    this.theme = "",
    this.language = "",
    this.timezone = "",
    this.showReadingTime = false,
    this.lastLoginAt = "",
    this.token = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  UserEntity toEntity() => UserEntity(id: id, username: username, isAdmin: isAdmin);

}