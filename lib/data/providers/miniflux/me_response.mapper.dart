// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'me_response.dart';

class MeResponseMapper extends ClassMapperBase<MeResponse> {
  MeResponseMapper._();

  static MeResponseMapper? _instance;
  static MeResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MeResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MeResponse';

  static int _$id(MeResponse v) => v.id;
  static const Field<MeResponse, int> _f$id = Field('id', _$id);
  static String _$username(MeResponse v) => v.username;
  static const Field<MeResponse, String> _f$username =
      Field('username', _$username);

  @override
  final MappableFields<MeResponse> fields = const {
    #id: _f$id,
    #username: _f$username,
  };

  static MeResponse _instantiate(DecodingData data) {
    return MeResponse(id: data.dec(_f$id), username: data.dec(_f$username));
  }

  @override
  final Function instantiate = _instantiate;

  static MeResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MeResponse>(map);
  }

  static MeResponse fromJson(String json) {
    return ensureInitialized().decodeJson<MeResponse>(json);
  }
}

mixin MeResponseMappable {
  String toJson() {
    return MeResponseMapper.ensureInitialized()
        .encodeJson<MeResponse>(this as MeResponse);
  }

  Map<String, dynamic> toMap() {
    return MeResponseMapper.ensureInitialized()
        .encodeMap<MeResponse>(this as MeResponse);
  }

  MeResponseCopyWith<MeResponse, MeResponse, MeResponse> get copyWith =>
      _MeResponseCopyWithImpl<MeResponse, MeResponse>(
          this as MeResponse, $identity, $identity);
  @override
  String toString() {
    return MeResponseMapper.ensureInitialized()
        .stringifyValue(this as MeResponse);
  }

  @override
  bool operator ==(Object other) {
    return MeResponseMapper.ensureInitialized()
        .equalsValue(this as MeResponse, other);
  }

  @override
  int get hashCode {
    return MeResponseMapper.ensureInitialized().hashValue(this as MeResponse);
  }
}

extension MeResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MeResponse, $Out> {
  MeResponseCopyWith<$R, MeResponse, $Out> get $asMeResponse =>
      $base.as((v, t, t2) => _MeResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MeResponseCopyWith<$R, $In extends MeResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? username});
  MeResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MeResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MeResponse, $Out>
    implements MeResponseCopyWith<$R, MeResponse, $Out> {
  _MeResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MeResponse> $mapper =
      MeResponseMapper.ensureInitialized();
  @override
  $R call({int? id, String? username}) => $apply(FieldCopyWithData(
      {if (id != null) #id: id, if (username != null) #username: username}));
  @override
  MeResponse $make(CopyWithData data) => MeResponse(
      id: data.get(#id, or: $value.id),
      username: data.get(#username, or: $value.username));

  @override
  MeResponseCopyWith<$R2, MeResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MeResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
