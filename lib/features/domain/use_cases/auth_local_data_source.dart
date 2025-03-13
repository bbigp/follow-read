// abstract class AuthLocalDataSource {
//   Future<void> cacheUser(UserModel user);
//   Future<UserModel?> getCachedUser();
// }
//
// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   final SharedPreferences _prefs;
//
//   AuthLocalDataSourceImpl(this._prefs);
//
//   @override
//   Future<void> cacheUser(UserModel user) async {
//     await _prefs.setString('cachedUser', jsonEncode(user.toJson()));
//   }
//
//   @override
//   Future<UserModel?> getCachedUser() async {
//     final json = _prefs.getString('cachedUser');
//     return json != null ? UserModel.fromJson(jsonDecode(json)) : null;
//   }
// }