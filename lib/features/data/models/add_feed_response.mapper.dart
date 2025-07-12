// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'add_feed_response.dart';

class AddFeedResponseMapper extends ClassMapperBase<AddFeedResponse> {
  AddFeedResponseMapper._();

  static AddFeedResponseMapper? _instance;
  static AddFeedResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AddFeedResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AddFeedResponse';

  static BigInt _$feedId(AddFeedResponse v) => v.feedId;
  static const Field<AddFeedResponse, BigInt> _f$feedId =
      Field('feedId', _$feedId, key: r'feed_id');

  @override
  final MappableFields<AddFeedResponse> fields = const {
    #feedId: _f$feedId,
  };

  static AddFeedResponse _instantiate(DecodingData data) {
    return AddFeedResponse(feedId: data.dec(_f$feedId));
  }

  @override
  final Function instantiate = _instantiate;

  static AddFeedResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AddFeedResponse>(map);
  }

  static AddFeedResponse fromJson(String json) {
    return ensureInitialized().decodeJson<AddFeedResponse>(json);
  }
}

mixin AddFeedResponseMappable {
  String toJson() {
    return AddFeedResponseMapper.ensureInitialized()
        .encodeJson<AddFeedResponse>(this as AddFeedResponse);
  }

  Map<String, dynamic> toMap() {
    return AddFeedResponseMapper.ensureInitialized()
        .encodeMap<AddFeedResponse>(this as AddFeedResponse);
  }

  AddFeedResponseCopyWith<AddFeedResponse, AddFeedResponse, AddFeedResponse>
      get copyWith =>
          _AddFeedResponseCopyWithImpl<AddFeedResponse, AddFeedResponse>(
              this as AddFeedResponse, $identity, $identity);
  @override
  String toString() {
    return AddFeedResponseMapper.ensureInitialized()
        .stringifyValue(this as AddFeedResponse);
  }

  @override
  bool operator ==(Object other) {
    return AddFeedResponseMapper.ensureInitialized()
        .equalsValue(this as AddFeedResponse, other);
  }

  @override
  int get hashCode {
    return AddFeedResponseMapper.ensureInitialized()
        .hashValue(this as AddFeedResponse);
  }
}

extension AddFeedResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AddFeedResponse, $Out> {
  AddFeedResponseCopyWith<$R, AddFeedResponse, $Out> get $asAddFeedResponse =>
      $base.as((v, t, t2) => _AddFeedResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AddFeedResponseCopyWith<$R, $In extends AddFeedResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({BigInt? feedId});
  AddFeedResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AddFeedResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AddFeedResponse, $Out>
    implements AddFeedResponseCopyWith<$R, AddFeedResponse, $Out> {
  _AddFeedResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AddFeedResponse> $mapper =
      AddFeedResponseMapper.ensureInitialized();
  @override
  $R call({BigInt? feedId}) =>
      $apply(FieldCopyWithData({if (feedId != null) #feedId: feedId}));
  @override
  AddFeedResponse $make(CopyWithData data) =>
      AddFeedResponse(feedId: data.get(#feedId, or: $value.feedId));

  @override
  AddFeedResponseCopyWith<$R2, AddFeedResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AddFeedResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
