


import 'dart:convert';

import 'package:follow_read/features/domain/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {

  LocalData();

  Future<void> cacheUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cachedUser', jsonEncode(user.toJson()));
  }

  Future<User?> getCachedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('cachedUser');
    return json != null ? UserMapper.fromJson(jsonDecode(json)) : null;
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cachedUser');
  }
}