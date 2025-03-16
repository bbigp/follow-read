// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_response.dart';

class UserResponseMapper extends ClassMapperBase<UserResponse> {
  UserResponseMapper._();

  static UserResponseMapper? _instance;
  static UserResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserResponse';

  static int _$id(UserResponse v) => v.id;
  static const Field<UserResponse, int> _f$id = Field('id', _$id);
  static String _$username(UserResponse v) => v.username;
  static const Field<UserResponse, String> _f$username =
      Field('username', _$username);
  static bool _$isAdmin(UserResponse v) => v.isAdmin;
  static const Field<UserResponse, bool> _f$isAdmin =
      Field('isAdmin', _$isAdmin, key: r'is_admin');
  static String _$theme(UserResponse v) => v.theme;
  static const Field<UserResponse, String> _f$theme = Field('theme', _$theme);
  static String _$language(UserResponse v) => v.language;
  static const Field<UserResponse, String> _f$language =
      Field('language', _$language);
  static String _$timezone(UserResponse v) => v.timezone;
  static const Field<UserResponse, String> _f$timezone =
      Field('timezone', _$timezone);
  static bool _$showReadingTime(UserResponse v) => v.showReadingTime;
  static const Field<UserResponse, bool> _f$showReadingTime =
      Field('showReadingTime', _$showReadingTime, key: r'show_reading_time');
  static String _$lastLoginAt(UserResponse v) => v.lastLoginAt;
  static const Field<UserResponse, String> _f$lastLoginAt =
      Field('lastLoginAt', _$lastLoginAt, key: r'last_login_at');

  @override
  final MappableFields<UserResponse> fields = const {
    #id: _f$id,
    #username: _f$username,
    #isAdmin: _f$isAdmin,
    #theme: _f$theme,
    #language: _f$language,
    #timezone: _f$timezone,
    #showReadingTime: _f$showReadingTime,
    #lastLoginAt: _f$lastLoginAt,
  };

  static UserResponse _instantiate(DecodingData data) {
    return UserResponse(
        id: data.dec(_f$id),
        username: data.dec(_f$username),
        isAdmin: data.dec(_f$isAdmin),
        theme: data.dec(_f$theme),
        language: data.dec(_f$language),
        timezone: data.dec(_f$timezone),
        showReadingTime: data.dec(_f$showReadingTime),
        lastLoginAt: data.dec(_f$lastLoginAt));
  }

  @override
  final Function instantiate = _instantiate;

  static UserResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserResponse>(map);
  }

  static UserResponse fromJson(String json) {
    return ensureInitialized().decodeJson<UserResponse>(json);
  }
}

mixin UserResponseMappable {
  String toJson() {
    return UserResponseMapper.ensureInitialized()
        .encodeJson<UserResponse>(this as UserResponse);
  }

  Map<String, dynamic> toMap() {
    return UserResponseMapper.ensureInitialized()
        .encodeMap<UserResponse>(this as UserResponse);
  }

  UserResponseCopyWith<UserResponse, UserResponse, UserResponse> get copyWith =>
      _UserResponseCopyWithImpl<UserResponse, UserResponse>(
          this as UserResponse, $identity, $identity);
  @override
  String toString() {
    return UserResponseMapper.ensureInitialized()
        .stringifyValue(this as UserResponse);
  }

  @override
  bool operator ==(Object other) {
    return UserResponseMapper.ensureInitialized()
        .equalsValue(this as UserResponse, other);
  }

  @override
  int get hashCode {
    return UserResponseMapper.ensureInitialized()
        .hashValue(this as UserResponse);
  }
}

extension UserResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserResponse, $Out> {
  UserResponseCopyWith<$R, UserResponse, $Out> get $asUserResponse =>
      $base.as((v, t, t2) => _UserResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserResponseCopyWith<$R, $In extends UserResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? id,
      String? username,
      bool? isAdmin,
      String? theme,
      String? language,
      String? timezone,
      bool? showReadingTime,
      String? lastLoginAt});
  UserResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserResponse, $Out>
    implements UserResponseCopyWith<$R, UserResponse, $Out> {
  _UserResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserResponse> $mapper =
      UserResponseMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          String? username,
          bool? isAdmin,
          String? theme,
          String? language,
          String? timezone,
          bool? showReadingTime,
          String? lastLoginAt}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (username != null) #username: username,
        if (isAdmin != null) #isAdmin: isAdmin,
        if (theme != null) #theme: theme,
        if (language != null) #language: language,
        if (timezone != null) #timezone: timezone,
        if (showReadingTime != null) #showReadingTime: showReadingTime,
        if (lastLoginAt != null) #lastLoginAt: lastLoginAt
      }));
  @override
  UserResponse $make(CopyWithData data) => UserResponse(
      id: data.get(#id, or: $value.id),
      username: data.get(#username, or: $value.username),
      isAdmin: data.get(#isAdmin, or: $value.isAdmin),
      theme: data.get(#theme, or: $value.theme),
      language: data.get(#language, or: $value.language),
      timezone: data.get(#timezone, or: $value.timezone),
      showReadingTime: data.get(#showReadingTime, or: $value.showReadingTime),
      lastLoginAt: data.get(#lastLoginAt, or: $value.lastLoginAt));

  @override
  UserResponseCopyWith<$R2, UserResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
