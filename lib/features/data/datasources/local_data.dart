


import 'dart:convert';

import 'package:follow_read/features/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  final SharedPreferences _prefs;

  LocalData(this._prefs);

  Future<void> cacheUser(UserEntity user) async {
    await _prefs.setString('cachedUser', jsonEncode(user.toJson()));
  }

  Future<UserEntity?> getCachedUser() async {
    final json = _prefs.getString('cachedUser');
    return json != null ? UserEntityMapper.fromJson(jsonDecode(json)) : null;
  }

  Future<void> deleteUser() async {
    await _prefs.remove('cachedUser');
  }
}