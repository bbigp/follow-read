// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'media.dart';

class MediaResponseMapper extends ClassMapperBase<MediaResponse> {
  MediaResponseMapper._();

  static MediaResponseMapper? _instance;
  static MediaResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MediaResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MediaResponse';

  static BigInt _$id(MediaResponse v) => v.id;
  static const Field<MediaResponse, BigInt> _f$id = Field('id', _$id);
  static BigInt _$userId(MediaResponse v) => v.userId;
  static const Field<MediaResponse, BigInt> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static BigInt _$entryId(MediaResponse v) => v.entryId;
  static const Field<MediaResponse, BigInt> _f$entryId =
      Field('entryId', _$entryId, key: r'entry_id');
  static String _$url(MediaResponse v) => v.url;
  static const Field<MediaResponse, String> _f$url = Field('url', _$url);
  static String _$mimeType(MediaResponse v) => v.mimeType;
  static const Field<MediaResponse, String> _f$mimeType =
      Field('mimeType', _$mimeType, key: r'mime_type');
  static int _$size(MediaResponse v) => v.size;
  static const Field<MediaResponse, int> _f$size = Field('size', _$size);
  static int _$mediaProgression(MediaResponse v) => v.mediaProgression;
  static const Field<MediaResponse, int> _f$mediaProgression =
      Field('mediaProgression', _$mediaProgression, key: r'media_progression');

  @override
  final MappableFields<MediaResponse> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #entryId: _f$entryId,
    #url: _f$url,
    #mimeType: _f$mimeType,
    #size: _f$size,
    #mediaProgression: _f$mediaProgression,
  };

  static MediaResponse _instantiate(DecodingData data) {
    return MediaResponse(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        entryId: data.dec(_f$entryId),
        url: data.dec(_f$url),
        mimeType: data.dec(_f$mimeType),
        size: data.dec(_f$size),
        mediaProgression: data.dec(_f$mediaProgression));
  }

  @override
  final Function instantiate = _instantiate;

  static MediaResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MediaResponse>(map);
  }

  static MediaResponse fromJson(String json) {
    return ensureInitialized().decodeJson<MediaResponse>(json);
  }
}

mixin MediaResponseMappable {
  String toJson() {
    return MediaResponseMapper.ensureInitialized()
        .encodeJson<MediaResponse>(this as MediaResponse);
  }

  Map<String, dynamic> toMap() {
    return MediaResponseMapper.ensureInitialized()
        .encodeMap<MediaResponse>(this as MediaResponse);
  }

  MediaResponseCopyWith<MediaResponse, MediaResponse, MediaResponse>
      get copyWith => _MediaResponseCopyWithImpl<MediaResponse, MediaResponse>(
          this as MediaResponse, $identity, $identity);
  @override
  String toString() {
    return MediaResponseMapper.ensureInitialized()
        .stringifyValue(this as MediaResponse);
  }

  @override
  bool operator ==(Object other) {
    return MediaResponseMapper.ensureInitialized()
        .equalsValue(this as MediaResponse, other);
  }

  @override
  int get hashCode {
    return MediaResponseMapper.ensureInitialized()
        .hashValue(this as MediaResponse);
  }
}

extension MediaResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MediaResponse, $Out> {
  MediaResponseCopyWith<$R, MediaResponse, $Out> get $asMediaResponse =>
      $base.as((v, t, t2) => _MediaResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MediaResponseCopyWith<$R, $In extends MediaResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {BigInt? id,
      BigInt? userId,
      BigInt? entryId,
      String? url,
      String? mimeType,
      int? size,
      int? mediaProgression});
  MediaResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MediaResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MediaResponse, $Out>
    implements MediaResponseCopyWith<$R, MediaResponse, $Out> {
  _MediaResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MediaResponse> $mapper =
      MediaResponseMapper.ensureInitialized();
  @override
  $R call(
          {BigInt? id,
          BigInt? userId,
          BigInt? entryId,
          String? url,
          String? mimeType,
          int? size,
          int? mediaProgression}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (userId != null) #userId: userId,
        if (entryId != null) #entryId: entryId,
        if (url != null) #url: url,
        if (mimeType != null) #mimeType: mimeType,
        if (size != null) #size: size,
        if (mediaProgression != null) #mediaProgression: mediaProgression
      }));
  @override
  MediaResponse $make(CopyWithData data) => MediaResponse(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      entryId: data.get(#entryId, or: $value.entryId),
      url: data.get(#url, or: $value.url),
      mimeType: data.get(#mimeType, or: $value.mimeType),
      size: data.get(#size, or: $value.size),
      mediaProgression:
          data.get(#mediaProgression, or: $value.mediaProgression));

  @override
  MediaResponseCopyWith<$R2, MediaResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MediaResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
