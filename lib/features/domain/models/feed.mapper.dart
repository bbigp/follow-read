// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'feed.dart';

class FeedMapper extends ClassMapperBase<Feed> {
  FeedMapper._();

  static FeedMapper? _instance;
  static FeedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeedMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Feed';

  static BigInt _$id(Feed v) => v.id;
  static const Field<Feed, BigInt> _f$id = Field('id', _$id);
  static BigInt _$userId(Feed v) => v.userId;
  static const Field<Feed, BigInt> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static String _$feedUrl(Feed v) => v.feedUrl;
  static const Field<Feed, String> _f$feedUrl =
      Field('feedUrl', _$feedUrl, key: r'feed_url');
  static String _$siteUrl(Feed v) => v.siteUrl;
  static const Field<Feed, String> _f$siteUrl =
      Field('siteUrl', _$siteUrl, key: r'site_url');
  static String _$title(Feed v) => v.title;
  static const Field<Feed, String> _f$title = Field('title', _$title);
  static String? _$avatarUrl(Feed v) => v.avatarUrl;
  static const Field<Feed, String> _f$avatarUrl =
      Field('avatarUrl', _$avatarUrl, opt: true);
  static int? _$unreadCount(Feed v) => v.unreadCount;
  static const Field<Feed, int> _f$unreadCount =
      Field('unreadCount', _$unreadCount, opt: true);

  @override
  final MappableFields<Feed> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #feedUrl: _f$feedUrl,
    #siteUrl: _f$siteUrl,
    #title: _f$title,
    #avatarUrl: _f$avatarUrl,
    #unreadCount: _f$unreadCount,
  };

  static Feed _instantiate(DecodingData data) {
    return Feed(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        feedUrl: data.dec(_f$feedUrl),
        siteUrl: data.dec(_f$siteUrl),
        title: data.dec(_f$title),
        avatarUrl: data.dec(_f$avatarUrl),
        unreadCount: data.dec(_f$unreadCount));
  }

  @override
  final Function instantiate = _instantiate;

  static Feed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Feed>(map);
  }

  static Feed fromJson(String json) {
    return ensureInitialized().decodeJson<Feed>(json);
  }
}

mixin FeedMappable {
  String toJson() {
    return FeedMapper.ensureInitialized().encodeJson<Feed>(this as Feed);
  }

  Map<String, dynamic> toMap() {
    return FeedMapper.ensureInitialized().encodeMap<Feed>(this as Feed);
  }

  FeedCopyWith<Feed, Feed, Feed> get copyWith =>
      _FeedCopyWithImpl<Feed, Feed>(this as Feed, $identity, $identity);
  @override
  String toString() {
    return FeedMapper.ensureInitialized().stringifyValue(this as Feed);
  }

  @override
  bool operator ==(Object other) {
    return FeedMapper.ensureInitialized().equalsValue(this as Feed, other);
  }

  @override
  int get hashCode {
    return FeedMapper.ensureInitialized().hashValue(this as Feed);
  }
}

extension FeedValueCopy<$R, $Out> on ObjectCopyWith<$R, Feed, $Out> {
  FeedCopyWith<$R, Feed, $Out> get $asFeed =>
      $base.as((v, t, t2) => _FeedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FeedCopyWith<$R, $In extends Feed, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {BigInt? id,
      BigInt? userId,
      String? feedUrl,
      String? siteUrl,
      String? title,
      String? avatarUrl,
      int? unreadCount});
  FeedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FeedCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Feed, $Out>
    implements FeedCopyWith<$R, Feed, $Out> {
  _FeedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Feed> $mapper = FeedMapper.ensureInitialized();
  @override
  $R call(
          {BigInt? id,
          BigInt? userId,
          String? feedUrl,
          String? siteUrl,
          String? title,
          Object? avatarUrl = $none,
          Object? unreadCount = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (userId != null) #userId: userId,
        if (feedUrl != null) #feedUrl: feedUrl,
        if (siteUrl != null) #siteUrl: siteUrl,
        if (title != null) #title: title,
        if (avatarUrl != $none) #avatarUrl: avatarUrl,
        if (unreadCount != $none) #unreadCount: unreadCount
      }));
  @override
  Feed $make(CopyWithData data) => Feed(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      feedUrl: data.get(#feedUrl, or: $value.feedUrl),
      siteUrl: data.get(#siteUrl, or: $value.siteUrl),
      title: data.get(#title, or: $value.title),
      avatarUrl: data.get(#avatarUrl, or: $value.avatarUrl),
      unreadCount: data.get(#unreadCount, or: $value.unreadCount));

  @override
  FeedCopyWith<$R2, Feed, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FeedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
