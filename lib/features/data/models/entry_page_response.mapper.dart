// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'entry_page_response.dart';

class EntryPageResponseMapper extends ClassMapperBase<EntryPageResponse> {
  EntryPageResponseMapper._();

  static EntryPageResponseMapper? _instance;
  static EntryPageResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EntryPageResponseMapper._());
      EntryResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EntryPageResponse';

  static int _$total(EntryPageResponse v) => v.total;
  static const Field<EntryPageResponse, int> _f$total = Field('total', _$total);
  static List<EntryResponse> _$entries(EntryPageResponse v) => v.entries;
  static const Field<EntryPageResponse, List<EntryResponse>> _f$entries =
      Field('entries', _$entries);

  @override
  final MappableFields<EntryPageResponse> fields = const {
    #total: _f$total,
    #entries: _f$entries,
  };

  static EntryPageResponse _instantiate(DecodingData data) {
    return EntryPageResponse(
        total: data.dec(_f$total), entries: data.dec(_f$entries));
  }

  @override
  final Function instantiate = _instantiate;

  static EntryPageResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EntryPageResponse>(map);
  }

  static EntryPageResponse fromJson(String json) {
    return ensureInitialized().decodeJson<EntryPageResponse>(json);
  }
}

mixin EntryPageResponseMappable {
  String toJson() {
    return EntryPageResponseMapper.ensureInitialized()
        .encodeJson<EntryPageResponse>(this as EntryPageResponse);
  }

  Map<String, dynamic> toMap() {
    return EntryPageResponseMapper.ensureInitialized()
        .encodeMap<EntryPageResponse>(this as EntryPageResponse);
  }

  EntryPageResponseCopyWith<EntryPageResponse, EntryPageResponse,
          EntryPageResponse>
      get copyWith =>
          _EntryPageResponseCopyWithImpl<EntryPageResponse, EntryPageResponse>(
              this as EntryPageResponse, $identity, $identity);
  @override
  String toString() {
    return EntryPageResponseMapper.ensureInitialized()
        .stringifyValue(this as EntryPageResponse);
  }

  @override
  bool operator ==(Object other) {
    return EntryPageResponseMapper.ensureInitialized()
        .equalsValue(this as EntryPageResponse, other);
  }

  @override
  int get hashCode {
    return EntryPageResponseMapper.ensureInitialized()
        .hashValue(this as EntryPageResponse);
  }
}

extension EntryPageResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EntryPageResponse, $Out> {
  EntryPageResponseCopyWith<$R, EntryPageResponse, $Out>
      get $asEntryPageResponse => $base
          .as((v, t, t2) => _EntryPageResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EntryPageResponseCopyWith<$R, $In extends EntryPageResponse,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, EntryResponse,
      EntryResponseCopyWith<$R, EntryResponse, EntryResponse>> get entries;
  $R call({int? total, List<EntryResponse>? entries});
  EntryPageResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _EntryPageResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EntryPageResponse, $Out>
    implements EntryPageResponseCopyWith<$R, EntryPageResponse, $Out> {
  _EntryPageResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EntryPageResponse> $mapper =
      EntryPageResponseMapper.ensureInitialized();
  @override
  ListCopyWith<$R, EntryResponse,
          EntryResponseCopyWith<$R, EntryResponse, EntryResponse>>
      get entries => ListCopyWith($value.entries,
          (v, t) => v.copyWith.$chain(t), (v) => call(entries: v));
  @override
  $R call({int? total, List<EntryResponse>? entries}) =>
      $apply(FieldCopyWithData({
        if (total != null) #total: total,
        if (entries != null) #entries: entries
      }));
  @override
  EntryPageResponse $make(CopyWithData data) => EntryPageResponse(
      total: data.get(#total, or: $value.total),
      entries: data.get(#entries, or: $value.entries));

  @override
  EntryPageResponseCopyWith<$R2, EntryPageResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EntryPageResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class EntryResponseMapper extends ClassMapperBase<EntryResponse> {
  EntryResponseMapper._();

  static EntryResponseMapper? _instance;
  static EntryResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EntryResponseMapper._());
      FeedResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'EntryResponse';

  static int _$id(EntryResponse v) => v.id;
  static const Field<EntryResponse, int> _f$id = Field('id', _$id);
  static int _$userId(EntryResponse v) => v.userId;
  static const Field<EntryResponse, int> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static int _$feedId(EntryResponse v) => v.feedId;
  static const Field<EntryResponse, int> _f$feedId =
      Field('feedId', _$feedId, key: r'feed_id');
  static String _$status(EntryResponse v) => v.status;
  static const Field<EntryResponse, String> _f$status =
      Field('status', _$status);
  static String _$hash(EntryResponse v) => v.hash;
  static const Field<EntryResponse, String> _f$hash = Field('hash', _$hash);
  static String _$title(EntryResponse v) => v.title;
  static const Field<EntryResponse, String> _f$title = Field('title', _$title);
  static String _$url(EntryResponse v) => v.url;
  static const Field<EntryResponse, String> _f$url = Field('url', _$url);
  static String? _$commentsUrl(EntryResponse v) => v.commentsUrl;
  static const Field<EntryResponse, String> _f$commentsUrl =
      Field('commentsUrl', _$commentsUrl, key: r'comments_url');
  static DateTime _$publishedAt(EntryResponse v) => v.publishedAt;
  static const Field<EntryResponse, DateTime> _f$publishedAt =
      Field('publishedAt', _$publishedAt, key: r'published_at');
  static DateTime _$createdAt(EntryResponse v) => v.createdAt;
  static const Field<EntryResponse, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, key: r'created_at');
  static DateTime _$changedAt(EntryResponse v) => v.changedAt;
  static const Field<EntryResponse, DateTime> _f$changedAt =
      Field('changedAt', _$changedAt, key: r'changed_at');
  static String _$content(EntryResponse v) => v.content;
  static const Field<EntryResponse, String> _f$content =
      Field('content', _$content);
  static String _$author(EntryResponse v) => v.author;
  static const Field<EntryResponse, String> _f$author =
      Field('author', _$author);
  static String _$shareCode(EntryResponse v) => v.shareCode;
  static const Field<EntryResponse, String> _f$shareCode =
      Field('shareCode', _$shareCode, key: r'share_code');
  static bool _$starred(EntryResponse v) => v.starred;
  static const Field<EntryResponse, bool> _f$starred =
      Field('starred', _$starred);
  static int _$readingTime(EntryResponse v) => v.readingTime;
  static const Field<EntryResponse, int> _f$readingTime =
      Field('readingTime', _$readingTime, key: r'reading_time');
  static FeedResponse _$feed(EntryResponse v) => v.feed;
  static const Field<EntryResponse, FeedResponse> _f$feed =
      Field('feed', _$feed);

  @override
  final MappableFields<EntryResponse> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #feedId: _f$feedId,
    #status: _f$status,
    #hash: _f$hash,
    #title: _f$title,
    #url: _f$url,
    #commentsUrl: _f$commentsUrl,
    #publishedAt: _f$publishedAt,
    #createdAt: _f$createdAt,
    #changedAt: _f$changedAt,
    #content: _f$content,
    #author: _f$author,
    #shareCode: _f$shareCode,
    #starred: _f$starred,
    #readingTime: _f$readingTime,
    #feed: _f$feed,
  };

  static EntryResponse _instantiate(DecodingData data) {
    return EntryResponse(
        id: data.dec(_f$id),
        userId: data.dec(_f$userId),
        feedId: data.dec(_f$feedId),
        status: data.dec(_f$status),
        hash: data.dec(_f$hash),
        title: data.dec(_f$title),
        url: data.dec(_f$url),
        commentsUrl: data.dec(_f$commentsUrl),
        publishedAt: data.dec(_f$publishedAt),
        createdAt: data.dec(_f$createdAt),
        changedAt: data.dec(_f$changedAt),
        content: data.dec(_f$content),
        author: data.dec(_f$author),
        shareCode: data.dec(_f$shareCode),
        starred: data.dec(_f$starred),
        readingTime: data.dec(_f$readingTime),
        feed: data.dec(_f$feed));
  }

  @override
  final Function instantiate = _instantiate;

  static EntryResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EntryResponse>(map);
  }

  static EntryResponse fromJson(String json) {
    return ensureInitialized().decodeJson<EntryResponse>(json);
  }
}

mixin EntryResponseMappable {
  String toJson() {
    return EntryResponseMapper.ensureInitialized()
        .encodeJson<EntryResponse>(this as EntryResponse);
  }

  Map<String, dynamic> toMap() {
    return EntryResponseMapper.ensureInitialized()
        .encodeMap<EntryResponse>(this as EntryResponse);
  }

  EntryResponseCopyWith<EntryResponse, EntryResponse, EntryResponse>
      get copyWith => _EntryResponseCopyWithImpl<EntryResponse, EntryResponse>(
          this as EntryResponse, $identity, $identity);
  @override
  String toString() {
    return EntryResponseMapper.ensureInitialized()
        .stringifyValue(this as EntryResponse);
  }

  @override
  bool operator ==(Object other) {
    return EntryResponseMapper.ensureInitialized()
        .equalsValue(this as EntryResponse, other);
  }

  @override
  int get hashCode {
    return EntryResponseMapper.ensureInitialized()
        .hashValue(this as EntryResponse);
  }
}

extension EntryResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EntryResponse, $Out> {
  EntryResponseCopyWith<$R, EntryResponse, $Out> get $asEntryResponse =>
      $base.as((v, t, t2) => _EntryResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EntryResponseCopyWith<$R, $In extends EntryResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  FeedResponseCopyWith<$R, FeedResponse, FeedResponse> get feed;
  $R call(
      {int? id,
      int? userId,
      int? feedId,
      String? status,
      String? hash,
      String? title,
      String? url,
      String? commentsUrl,
      DateTime? publishedAt,
      DateTime? createdAt,
      DateTime? changedAt,
      String? content,
      String? author,
      String? shareCode,
      bool? starred,
      int? readingTime,
      FeedResponse? feed});
  EntryResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EntryResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EntryResponse, $Out>
    implements EntryResponseCopyWith<$R, EntryResponse, $Out> {
  _EntryResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EntryResponse> $mapper =
      EntryResponseMapper.ensureInitialized();
  @override
  FeedResponseCopyWith<$R, FeedResponse, FeedResponse> get feed =>
      $value.feed.copyWith.$chain((v) => call(feed: v));
  @override
  $R call(
          {int? id,
          int? userId,
          int? feedId,
          String? status,
          String? hash,
          String? title,
          String? url,
          Object? commentsUrl = $none,
          DateTime? publishedAt,
          DateTime? createdAt,
          DateTime? changedAt,
          String? content,
          String? author,
          String? shareCode,
          bool? starred,
          int? readingTime,
          FeedResponse? feed}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (userId != null) #userId: userId,
        if (feedId != null) #feedId: feedId,
        if (status != null) #status: status,
        if (hash != null) #hash: hash,
        if (title != null) #title: title,
        if (url != null) #url: url,
        if (commentsUrl != $none) #commentsUrl: commentsUrl,
        if (publishedAt != null) #publishedAt: publishedAt,
        if (createdAt != null) #createdAt: createdAt,
        if (changedAt != null) #changedAt: changedAt,
        if (content != null) #content: content,
        if (author != null) #author: author,
        if (shareCode != null) #shareCode: shareCode,
        if (starred != null) #starred: starred,
        if (readingTime != null) #readingTime: readingTime,
        if (feed != null) #feed: feed
      }));
  @override
  EntryResponse $make(CopyWithData data) => EntryResponse(
      id: data.get(#id, or: $value.id),
      userId: data.get(#userId, or: $value.userId),
      feedId: data.get(#feedId, or: $value.feedId),
      status: data.get(#status, or: $value.status),
      hash: data.get(#hash, or: $value.hash),
      title: data.get(#title, or: $value.title),
      url: data.get(#url, or: $value.url),
      commentsUrl: data.get(#commentsUrl, or: $value.commentsUrl),
      publishedAt: data.get(#publishedAt, or: $value.publishedAt),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      changedAt: data.get(#changedAt, or: $value.changedAt),
      content: data.get(#content, or: $value.content),
      author: data.get(#author, or: $value.author),
      shareCode: data.get(#shareCode, or: $value.shareCode),
      starred: data.get(#starred, or: $value.starred),
      readingTime: data.get(#readingTime, or: $value.readingTime),
      feed: data.get(#feed, or: $value.feed));

  @override
  EntryResponseCopyWith<$R2, EntryResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EntryResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
