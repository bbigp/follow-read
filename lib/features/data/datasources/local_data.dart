


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class LocalData {
  final SharedPreferences _prefs;

  LocalData(this._prefs);

  Future<void> cacheUser(UserModel user) async {
    await _prefs.setString('cachedUser', jsonEncode(user.toJson()));
  }

  Future<UserModel?> getCachedUser() async {
    final json = _prefs.getString('cachedUser');
    return json != null ? UserModel.fromJson(jsonDecode(json)) : null;
  }
}