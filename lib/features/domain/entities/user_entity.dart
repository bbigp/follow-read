
import 'package:dart_mappable/dart_mappable.dart';

part 'user_entity.mapper.dart';

@MappableClass()
class UserEntity with UserEntityMappable {
  final int id;
  final String username;
  @MappableField(key: 'is_admin')
  final bool isAdmin;
  final String theme;
  final String language;
  final String timezone;
  @MappableField(key: 'show_reading_time')
  final bool showReadingTime;
  @MappableField(key: 'last_login_at')
  final String lastLoginAt;
  final String token;
  final String baseUrl;


  UserEntity({
    required this.id,
    required this.username,
    required this.isAdmin,
    this.token = "",
    this.theme = "",
    this.language = "",
    this.timezone = "",
    this.showReadingTime = false,
    this.lastLoginAt = "",
    this.baseUrl = "",
  });

}