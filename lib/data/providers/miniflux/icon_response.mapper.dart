// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'icon_response.dart';

class IconResponseMapper extends ClassMapperBase<IconResponse> {
  IconResponseMapper._();

  static IconResponseMapper? _instance;
  static IconResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = IconResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'IconResponse';

  static int _$feedId(IconResponse v) => v.feedId;
  static const Field<IconResponse, int> _f$feedId =
      Field('feedId', _$feedId, key: r'feed_id');
  static int _$iconId(IconResponse v) => v.iconId;
  static const Field<IconResponse, int> _f$iconId =
      Field('iconId', _$iconId, key: r'icon_id');

  @override
  final MappableFields<IconResponse> fields = const {
    #feedId: _f$feedId,
    #iconId: _f$iconId,
  };

  static IconResponse _instantiate(DecodingData data) {
    return IconResponse(
        feedId: data.dec(_f$feedId), iconId: data.dec(_f$iconId));
  }

  @override
  final Function instantiate = _instantiate;

  static IconResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<IconResponse>(map);
  }

  static IconResponse fromJson(String json) {
    return ensureInitialized().decodeJson<IconResponse>(json);
  }
}

mixin IconResponseMappable {
  String toJson() {
    return IconResponseMapper.ensureInitialized()
        .encodeJson<IconResponse>(this as IconResponse);
  }

  Map<String, dynamic> toMap() {
    return IconResponseMapper.ensureInitialized()
        .encodeMap<IconResponse>(this as IconResponse);
  }

  IconResponseCopyWith<IconResponse, IconResponse, IconResponse> get copyWith =>
      _IconResponseCopyWithImpl<IconResponse, IconResponse>(
          this as IconResponse, $identity, $identity);
  @override
  String toString() {
    return IconResponseMapper.ensureInitialized()
        .stringifyValue(this as IconResponse);
  }

  @override
  bool operator ==(Object other) {
    return IconResponseMapper.ensureInitialized()
        .equalsValue(this as IconResponse, other);
  }

  @override
  int get hashCode {
    return IconResponseMapper.ensureInitialized()
        .hashValue(this as IconResponse);
  }
}

extension IconResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, IconResponse, $Out> {
  IconResponseCopyWith<$R, IconResponse, $Out> get $asIconResponse =>
      $base.as((v, t, t2) => _IconResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class IconResponseCopyWith<$R, $In extends IconResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? feedId, int? iconId});
  IconResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _IconResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, IconResponse, $Out>
    implements IconResponseCopyWith<$R, IconResponse, $Out> {
  _IconResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<IconResponse> $mapper =
      IconResponseMapper.ensureInitialized();
  @override
  $R call({int? feedId, int? iconId}) => $apply(FieldCopyWithData({
        if (feedId != null) #feedId: feedId,
        if (iconId != null) #iconId: iconId
      }));
  @override
  IconResponse $make(CopyWithData data) => IconResponse(
      feedId: data.get(#feedId, or: $value.feedId),
      iconId: data.get(#iconId, or: $value.iconId));

  @override
  IconResponseCopyWith<$R2, IconResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _IconResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
