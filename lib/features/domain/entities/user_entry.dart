

class UserEntity {
  final int id;
  final String username;
  final bool isAdmin;
  final String theme;
  final String language;
  final String timezone;
  final bool showReadingTime;
  final String lastLoginAt;
  String token;


  UserEntity({
    required this.id,
    required this.username,
    required this.isAdmin,
    this.token = "",
    this.theme = "",
    this.language = "",
    this.timezone = "",
    this.showReadingTime = false,
    this.lastLoginAt = ""
  });
}