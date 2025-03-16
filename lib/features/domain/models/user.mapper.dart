// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user.dart';

class UserMapper extends ClassMapperBase<User> {
  UserMapper._();

  static UserMapper? _instance;
  static UserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'User';

  static int _$id(User v) => v.id;
  static const Field<User, int> _f$id = Field('id', _$id);
  static String _$username(User v) => v.username;
  static const Field<User, String> _f$username = Field('username', _$username);
  static bool _$isAdmin(User v) => v.isAdmin;
  static const Field<User, bool> _f$isAdmin =
      Field('isAdmin', _$isAdmin, key: r'is_admin');
  static String _$token(User v) => v.token;
  static const Field<User, String> _f$token =
      Field('token', _$token, opt: true, def: "");
  static String _$theme(User v) => v.theme;
  static const Field<User, String> _f$theme =
      Field('theme', _$theme, opt: true, def: "");
  static String _$language(User v) => v.language;
  static const Field<User, String> _f$language =
      Field('language', _$language, opt: true, def: "");
  static String _$timezone(User v) => v.timezone;
  static const Field<User, String> _f$timezone =
      Field('timezone', _$timezone, opt: true, def: "");
  static bool _$showReadingTime(User v) => v.showReadingTime;
  static const Field<User, bool> _f$showReadingTime = Field(
      'showReadingTime', _$showReadingTime,
      key: r'show_reading_time', opt: true, def: false);
  static String _$lastLoginAt(User v) => v.lastLoginAt;
  static const Field<User, String> _f$lastLoginAt = Field(
      'lastLoginAt', _$lastLoginAt,
      key: r'last_login_at', opt: true, def: "");
  static String _$baseUrl(User v) => v.baseUrl;
  static const Field<User, String> _f$baseUrl =
      Field('baseUrl', _$baseUrl, opt: true, def: "");

  @override
  final MappableFields<User> fields = const {
    #id: _f$id,
    #username: _f$username,
    #isAdmin: _f$isAdmin,
    #token: _f$token,
    #theme: _f$theme,
    #language: _f$language,
    #timezone: _f$timezone,
    #showReadingTime: _f$showReadingTime,
    #lastLoginAt: _f$lastLoginAt,
    #baseUrl: _f$baseUrl,
  };

  static User _instantiate(DecodingData data) {
    return User(
        id: data.dec(_f$id),
        username: data.dec(_f$username),
        isAdmin: data.dec(_f$isAdmin),
        token: data.dec(_f$token),
        theme: data.dec(_f$theme),
        language: data.dec(_f$language),
        timezone: data.dec(_f$timezone),
        showReadingTime: data.dec(_f$showReadingTime),
        lastLoginAt: data.dec(_f$lastLoginAt),
        baseUrl: data.dec(_f$baseUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static User fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<User>(map);
  }

  static User fromJson(String json) {
    return ensureInitialized().decodeJson<User>(json);
  }
}

mixin UserMappable {
  String toJson() {
    return UserMapper.ensureInitialized().encodeJson<User>(this as User);
  }

  Map<String, dynamic> toMap() {
    return UserMapper.ensureInitialized().encodeMap<User>(this as User);
  }

  UserCopyWith<User, User, User> get copyWith =>
      _UserCopyWithImpl<User, User>(this as User, $identity, $identity);
  @override
  String toString() {
    return UserMapper.ensureInitialized().stringifyValue(this as User);
  }

  @override
  bool operator ==(Object other) {
    return UserMapper.ensureInitialized().equalsValue(this as User, other);
  }

  @override
  int get hashCode {
    return UserMapper.ensureInitialized().hashValue(this as User);
  }
}

extension UserValueCopy<$R, $Out> on ObjectCopyWith<$R, User, $Out> {
  UserCopyWith<$R, User, $Out> get $asUser =>
      $base.as((v, t, t2) => _UserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserCopyWith<$R, $In extends User, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? username,
      bool? isAdmin,
      String? token,
      String? theme,
      String? language,
      String? timezone,
      bool? showReadingTime,
      String? lastLoginAt,
      String? baseUrl});
  UserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, User, $Out>
    implements UserCopyWith<$R, User, $Out> {
  _UserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<User> $mapper = UserMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          String? username,
          bool? isAdmin,
          String? token,
          String? theme,
          String? language,
          String? timezone,
          bool? showReadingTime,
          String? lastLoginAt,
          String? baseUrl}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (username != null) #username: username,
        if (isAdmin != null) #isAdmin: isAdmin,
        if (token != null) #token: token,
        if (theme != null) #theme: theme,
        if (language != null) #language: language,
        if (timezone != null) #timezone: timezone,
        if (showReadingTime != null) #showReadingTime: showReadingTime,
        if (lastLoginAt != null) #lastLoginAt: lastLoginAt,
        if (baseUrl != null) #baseUrl: baseUrl
      }));
  @override
  User $make(CopyWithData data) => User(
      id: data.get(#id, or: $value.id),
      username: data.get(#username, or: $value.username),
      isAdmin: data.get(#isAdmin, or: $value.isAdmin),
      token: data.get(#token, or: $value.token),
      theme: data.get(#theme, or: $value.theme),
      language: data.get(#language, or: $value.language),
      timezone: data.get(#timezone, or: $value.timezone),
      showReadingTime: data.get(#showReadingTime, or: $value.showReadingTime),
      lastLoginAt: data.get(#lastLoginAt, or: $value.lastLoginAt),
      baseUrl: data.get(#baseUrl, or: $value.baseUrl));

  @override
  UserCopyWith<$R2, User, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
