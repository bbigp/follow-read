


import 'dart:convert';

import 'package:follow_read/features/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  final SharedPreferences _prefs;

  LocalData(this._prefs);

  Future<void> cacheUser(User user) async {
    await _prefs.setString('cachedUser', jsonEncode(user.toJson()));
  }

  Future<User?> getCachedUser() async {
    final json = _prefs.getString('cachedUser');
    return json != null ? UserMapper.fromJson(jsonDecode(json)) : null;
  }

  Future<void> deleteUser() async {
    await _prefs.remove('cachedUser');
  }
}