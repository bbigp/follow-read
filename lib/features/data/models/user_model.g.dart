// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      isAdmin: json['is_admin'] as bool,
      theme: json['theme'] as String? ?? "",
      language: json['language'] as String? ?? "",
      timezone: json['timezone'] as String? ?? "",
      showReadingTime: json['show_reading_time'] as bool? ?? false,
      lastLoginAt: json['last_login_at'] as String? ?? "",
    );

Map<String, dynamic> _$UserToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'is_admin': instance.isAdmin,
      'theme': instance.theme,
      'language': instance.language,
      'timezone': instance.timezone,
      'show_reading_time': instance.showReadingTime,
      'last_login_at': instance.lastLoginAt,
    };
